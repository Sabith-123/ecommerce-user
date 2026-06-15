import 'dart:convert';
import 'dart:developer';
import 'package:ecommerce_user_app/features/auth/data/model/user_model.dart';
import 'package:ecommerce_user_app/general/core/typdef.dart';
import 'package:ecommerce_user_app/general/services/keywords_builder.dart';
import 'package:ecommerce_user_app/general/services/notification_services2.dart';
import 'package:ecommerce_user_app/general/utils/firebase_collections.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_user_app/general/core/failures/main_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sendotp_flutter_sdk/sendotp_flutter_sdk.dart';

class AuthImpl {
  final FirebaseAuth firebaseAuth;
  final FirebaseMessaging firebaseMessaging;
  final FirebaseFirestore firesStore;
  AuthImpl(this.firebaseAuth, this.firebaseMessaging, this.firesStore);

  // send otp repo

  FutureResult<String> sendOtp(String phoneNumber) async {
    final trimedPhoneNumber = phoneNumber.trim().replaceAll(" ", '');
    String number = trimedPhoneNumber;
    if (number.startsWith("+")) {
      number = number.substring(1);
    }
    if (number.length == 10) {
      number = "91$number";
    }
    try {
      final data = {'identifier': number};
      final response = await OTPWidget.sendOTP(data);
      log("OTP sent response: $response");
      // ✅ Extract from message field
      if (response is Map &&
          response?['type'] == 'success' &&
          response?['message'] != null) {
        final reqId = response?['message'];
        return right(reqId);
      } else {
        return left(
          MainFailure.serverFailure(errorMsg: 'Failed to send OTP. Try again.'),
        );
      }
    } catch (e) {
      log("❌ Error sending OTP: $e");
      return left(
        MainFailure.serverFailure(
          errorMsg: 'Something went wrong while sending OTP.',
        ),
      );
    }
  }

  // retry otp repo

  FutureResult<String> retryOpt(String reqId) async {
    try {
      final response = await OTPWidget.retryOTP({
        'reqId': reqId,
        'retryChannel': 11, // SMS
      });
      log("Retry OTP response: $response");
      return right('OTP sent successfully');
    } catch (e) {
      log("Error retrying OTP: $e");
      return left(
        MainFailure.serverFailure(
          errorMsg: 'Something went wrong while retrying OTP.',
        ),
      );
    }
  }

  // verify otp repo

  FutureResult<String> verifyOpt(String otp, String reqId) async {
    log("verifyOtp called with otp: $otp");
    try {
      // 1. Verify with MSG91 SDK
      final respons = await OTPWidget.verifyOTP({'otp': otp, 'reqId': reqId});
      log("OTP verification response: $respons");
      if (respons?['type'] == 'success') {
        // ✅ Use the JWT token returned from Msg91, not the reqId
        final msg91Token = respons?['message'];
        // 2. Call Cloud Function
        final uri = Uri.parse(
          'https://verifymsg91otpandgetcustomtoken-iju6ao4p5a-uc.a.run.app',
        );
        final apiResponse = await http.post(
          uri,
          headers: {'content-type': 'application/json'},
          body: jsonEncode({'msg91Token': msg91Token}),
        );
        if (apiResponse.statusCode == 200) {
          final data = jsonDecode(apiResponse.body);
          log("✅ Received data from API: $data");
          final customToken = data['firebaseToken'] as String;

          log("✅ Received custom token from API: $customToken");

          await FirebaseAuth.instance.signInWithCustomToken(customToken);
          final currentUser = firebaseAuth.currentUser;
          if (currentUser == null) {
            return left(
              MainFailure.serverFailure(errorMsg: 'Sign-in failed. No user.'),
            );
          }
          final userDoc = firesStore
              .collection(FirebaseCollections.users)
              .doc(currentUser.uid);
          final getUser = await userDoc.get();
          final fcmToken =
              await ForegroundNotificationService.getFcmTokenWithRetry(
                retryCount: 1,
              );
          await ForegroundNotificationService.subscribePostLoginTopics();
          if (getUser.data() != null) {
            // Existing user: best-effort FCM token update
            if (fcmToken != null) {
              await userDoc.update({'fcmToken': fcmToken});
              log("✅ Signed in with custom token, fcmToken updated.");
            } else {
              log(
                "⚠️ Signed in with custom token but FCM token is null; skipping fcmToken update.",
              );
              await ForegroundNotificationService.registerTokenAfterLogin(
                currentUser.uid,
              );
            }
          } else {
            // New flow: create user doc so all users can log in (no admin pre-add required).
            // Legacy (kept for possible future use): block login when user doc does not exist:
            // return left(MainFailure.serverFaliures(errMsg: 'User profile not found. Please contact support.'));
            // final deviceId = await getDeviceId();
            final phoneNumber =
                data['phoneNumber'] as String? ?? currentUser.phoneNumber ?? '';
            final minimalUser = {
              'id': currentUser.uid,
              'name': null,
              'phoneNumber': phoneNumber,
              'keywords': keywordsBuilder(''),
              'createdAt': FieldValue.serverTimestamp(),
              'updatedAt': FieldValue.serverTimestamp(),
              'fcmToken': fcmToken,
            };
            await userDoc.set(minimalUser);
            if (fcmToken == null) {
              await ForegroundNotificationService.registerTokenAfterLogin(
                currentUser.uid,
              );
            }
            log(
              "✅ Created new user doc users/${currentUser.uid}; signed in successfully.",
            );
          }
          return right('OTP verified successfully');
        } else {
          log(
            "❌ Failed to get custom token. Status: ${apiResponse.statusCode}",
          );
          log("❌ Response body: ${apiResponse.body}");
          return left(
            MainFailure.serverFailure(errorMsg: 'Failed to get custom token.'),
          );
        }
      } else {
        return left(
          MainFailure.serverFailure(errorMsg: 'Failed to verify OTP.'),
        );
      }
    } catch (e, st) {
      log("❌ Error verifying OTP and signing in: $e\n$st");
      return left(MainFailure.serverFailure(errorMsg: 'Failed to verify OTP.'));
    }
  }

  Stream<UserModel?> userDataStream() async* {
    final userId = firebaseAuth.currentUser?.uid;
    if (userId == null) {
      yield null;
      return;
    }
    yield* firesStore
        .collection(FirebaseCollections.users)
        .doc(userId)
        .snapshots()
        .map((doc) {
          if (doc.exists) {
            log('User data stream updated');
            final user = UserModel.fromMap(doc.data() as Map<String, dynamic>);
            log('User store categories count: ${user.name}');
            return user;
          }
          return null;
        });
  }

  FutureResult<Unit> updateUserName(String name) async {
    try {
      final User? user = firebaseAuth.currentUser;
      if (user == null) {
        return left(MainFailure.serverFailure(errorMsg: 'No User Found'));
      }
      final userId = user.uid;
      final trimedName = name.trim();
      await user.updateDisplayName(trimedName);
      final userDoc = firesStore
          .collection(FirebaseCollections.users)
          .doc(userId);
      final List<String> keyword = keywordsBuilder(trimedName);
      await userDoc.set({
        "name": trimedName,
        "keywords": keyword,
      }, SetOptions(merge: true));
      return right(unit);
    } catch (e, st) {
      log("Error updating user name: $e\n$st");
      return left(
        MainFailure.serverFailure(errorMsg: 'Failed to update user name.'),
      );
    }
  }

  FutureResult<Unit> signOut() async {
    try {
      final userId = firebaseAuth.currentUser?.uid;
      if (userId != null) {
        await ForegroundNotificationService.clearTokenOnLogout(userId);
      } else {
        try {
          await firebaseMessaging.deleteToken();
        } catch (e, st) {
          log(
            '⚠️ Failed to delete local FCM token on logout fallback: $e\n$st',
          );
        }
      }
      await firebaseAuth.signOut();
      return right(unit);
    } catch (e, st) {
      log('Failed to sign out: $e\n$st');
      return left(MainFailure.serverFailure(errorMsg: 'Failed to sign out.'));
    }
  }
}
