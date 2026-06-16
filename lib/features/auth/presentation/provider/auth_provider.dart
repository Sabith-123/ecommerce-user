import 'dart:async';
import 'dart:developer';

import 'package:ecommerce_user_app/features/auth/data/model/user_model.dart';
import 'package:ecommerce_user_app/features/auth/repo/auth_impl.dart';
import 'package:ecommerce_user_app/general/widgets/custom_toast.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthImpl authImpl;
  AuthProvider(this.authImpl);
  bool isVerifying = false;
  bool isUpdatingProfile = false;
  String? reqId;
  UserModel? userData;
  StreamSubscription<UserModel?>? userStreamSub;

  final TextEditingController phoneCtl = TextEditingController();
  final TextEditingController nameCtl = TextEditingController();
  final TextEditingController otpCtl = TextEditingController();

  Future<void> sendOtpFun({
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    final result = await authImpl.sendOtp(phoneCtl.text);
    result.fold(
      (l) {
        onError.call();
        log(l.errorMsg);
        return CToast.error(msg: l.errorMsg);
      },
      (r) {
        onSuccess.call();
        reqId = r;
        CToast.success(msg: 'OTP sent successfully');
      },
    );
  }

  Future<void> retryOtpFun() async {
    if (reqId == null) {
      log('requst id is null');
      CToast.error(msg: 'somethig went wrong request id not found');
      return;
    }
    final rsult = await authImpl.retryOpt(reqId!);
    rsult.fold(
      (l) {
        log(l.errorMsg);
        CToast.error(msg: l.errorMsg);
      },
      (r) {
        log('otp retried successfully');
      },
    );
  }

  Future<void> verifyOtpFun({
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    if (isVerifying) return;

    isVerifying = true;
    notifyListeners();
    try {
      if (reqId == null) {
        onError.call();
        log('requst id is null');
        CToast.error(msg: 'somethig went wrong request id not found');
        return;
      }
      final result = await authImpl.verifyOpt(otpCtl.text, reqId!);
      result.fold(
        (l) {
          onError.call();
          log(l.errorMsg);
          CToast.error(msg: l.errorMsg);
        },
        (r) {
          onSuccess.call();
          log('otp verified successfully');
        },
      );
    } finally {
      isVerifying = false;
      notifyListeners();
    }
  }

  /// After OTP verify,user and general config in parallel, then report success/failure.
  /// Caller can use [user] and [hasName] to decide navigation (e.g. name screen vs home).
  Future<void> checkUserAfterOtp({
    required Function(bool hasName) onSuccess,
    required VoidCallback onError,
  }) async {
    try {
      await Future.wait([fetchUser()]);
    } catch (e, st) {
      log('checkUserAfterOtp: $e', stackTrace: st);
      CToast.error(msg: 'Login failed. Please try again');
      onError();
    }
    final currentUser = userData;
    if (currentUser == null) {
      CToast.error(msg: 'Login failed. Please try again');
      onError();
      return;
    }
    final hasName = (currentUser.name ?? '').trim().isNotEmpty;
    onSuccess(hasName);
  }

  Future<UserModel?> fetchUser() async {
    await userStreamSub?.cancel();
    final completer = Completer<void>();
    final result = authImpl.userDataStream();
    userStreamSub = result.listen(
      (event) {
        userData = event;
        notifyListeners();
        if (!completer.isCompleted) {
          completer.complete();
        }
      },
      onError: (error) {
        if (!completer.isCompleted) {
          completer.completeError(error);
        }
      },
    );
    await completer.future;
    return userData;
  }

  Future<void> submitNameAndContinue({
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    if (isUpdatingProfile) return;
    isUpdatingProfile = true;
    notifyListeners();
    try {
      final trimedName = nameCtl.text.trim();
      if (trimedName.isEmpty) {
        CToast.error(msg: 'Please enter your name');
        return;
      }
      final result = await authImpl.updateUserName(trimedName);
      result.fold(
        (l) {
          log(l.errorMsg);
          CToast.error(msg: l.errorMsg);
        },
        (r) {
          onSuccess();
          notifyListeners();
        },
      );
    } finally {
      isUpdatingProfile = false;
      notifyListeners();
    }
  }

  Future<void> logOut({
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    await userStreamSub?.cancel();
    userStreamSub = null;
    final result = await authImpl.signOut();
    result.fold(
      (l) {
        onError();
        log(l.errorMsg);
        CToast.error(msg: 'field to logOut');
      },
      (r) {
        userData = null;
        onSuccess();
        notifyListeners();
      },
    );
  }
}
