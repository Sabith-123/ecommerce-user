import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_app/general/core/injection.dart';
import 'package:ecommerce_user_app/general/utils/firebase_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ForegroundNotificationService {
  static const MethodChannel _iosPushChannel = MethodChannel(
    'mishhal_app/notifications',
  );
  static const List<String> _postLoginTopics = <String>['all'];
  static bool _tokenRefreshSyncStarted = false;
  static Stream<String>? _tokenRefreshStream;

  static Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    log('🔔 BG message received: ${message.messageId}');
    await configureDependencies();
  }

  static Future<NotificationSettings>
  requestPermissionAndRegisterIfNeeded() async {
    final settings = await sl<FirebaseMessaging>().requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    log('🔔 Notification auth status: ${settings.authorizationStatus.name}');

    if (Platform.isIOS &&
        (settings.authorizationStatus == AuthorizationStatus.authorized ||
            settings.authorizationStatus == AuthorizationStatus.provisional)) {
      try {
        await _iosPushChannel.invokeMethod<void>(
          'registerForRemoteNotifications',
        );
        log('✅ Requested iOS remote notification registration.');
      } catch (e, st) {
        log(
          '⚠️ Failed to request iOS remote notification registration: $e\n$st',
        );
      }
    }

    return settings;
  }

  static Future<void> initNotification() async {
    await requestPermissionAndRegisterIfNeeded();
  }

  /* --------------------------------- ON MAIN -------------------------------- */
  static Future<void> messageInit({
    required AndroidNotificationChannel channel,
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    // iOS-only: controls banner/sound when app is in foreground.
    if (Platform.isIOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  /* ------------------------------ ON INIT STATE ----------------------------- */

  static void foregroundNotitficationInit({
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    required AndroidNotificationChannel channel,
  }) {
    // if (_isInitialized) return;
    // _isInitialized = true;

    // Initialization should happen once, not inside the listener
    flutterLocalNotificationsPlugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
        ),
      ),
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        log('Notification tapped: ${response.id}');
        log('Notification payload: ${response.payload}');
        // Handle notification tap
        if (response.payload != null) {
          // You can navigate to a specific screen based on the payload
          // For example:
          // navigatorKey.currentState?.pushNamed('/someRoute', arguments: response.payload);
        }
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      // ignore: unused_local_variable
      AndroidNotification? androidNotification = message.notification?.android;

      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          id: notification.hashCode,
          title: notification.title ?? 'no title',
          body: notification.body ?? 'no body',
          notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
              badgeNumber: 0,
            ),
          ),
        );
      }
    });
  }

  static Future<String?> getFcmTokenWithRetry({
    Duration timeout = const Duration(seconds: 8),
    int retryCount = 1,
  }) async {
    String? token;
    int attempt = 0;

    while (attempt <= retryCount && token == null) {
      attempt++;
      try {
        if (Platform.isIOS) {
          final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
          log(
            apnsToken == null
                ? '⚠️ iOS APNs token not available yet (attempt $attempt).'
                : '✅ iOS APNs token available (attempt $attempt).',
          );
        }

        token = await FirebaseMessaging.instance.getToken().timeout(timeout);
        log(
          token == null
              ? '⚠️ FCM token is null on attempt $attempt.'
              : '✅ FCM token fetched on attempt $attempt.',
        );
      } catch (e, st) {
        log('⚠️ FCM token fetch failed on attempt $attempt: $e\n$st');
      }

      if (token == null && attempt <= retryCount) {
        await Future<void>.delayed(const Duration(seconds: 2));
      }
    }

    return token;
  }

  static Future<void> registerTokenAfterLogin(String userId) async {
    final token = await getFcmTokenWithRetry();
    if (token == null) {
      log('⚠️ Continuing login without FCM token; backend update skipped.');
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollections.users)
          .doc(userId)
          .set({
            'fcmToken': token,
            'updatedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
      log('✅ Backend updated with latest FCM token.');
    } catch (e, st) {
      log('⚠️ Failed to save FCM token to backend: $e\n$st');
    }
  }

  static Future<void> subscribePostLoginTopics() async {
    for (final topic in _postLoginTopics) {
      try {
        await FirebaseMessaging.instance.subscribeToTopic(topic);
        log("✅ Subscribed to topic '$topic'.");
      } catch (e, st) {
        log("⚠️ Failed to subscribe to topic '$topic': $e\n$st");
      }
    }
  }

  static Future<void> clearTokenOnLogout(String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollections.users)
          .doc(userId)
          .set({
            'fcmToken': null,
            'updatedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
      log('✅ Cleared FCM token in backend on logout.');
    } catch (e, st) {
      log('⚠️ Failed to clear backend FCM token on logout: $e\n$st');
    }

    for (final topic in _postLoginTopics) {
      try {
        await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
        log("✅ Unsubscribed from topic '$topic'.");
      } catch (e, st) {
        log("⚠️ Failed to unsubscribe from topic '$topic': $e\n$st");
      }
    }

    try {
      await FirebaseMessaging.instance.deleteToken();
      log('✅ Deleted local FCM token on logout.');
    } catch (e, st) {
      log('⚠️ Failed to delete local FCM token on logout: $e\n$st');
    }
  }

  static Future<void> startTokenRefreshSync() async {
    if (_tokenRefreshSyncStarted) return;
    _tokenRefreshSyncStarted = true;
    _tokenRefreshStream ??= FirebaseMessaging.instance.onTokenRefresh
        .asBroadcastStream();

    _tokenRefreshStream!.listen((token) async {
      log('🔄 FCM token refreshed.');
      final userId = sl<FirebaseAuth>().currentUser?.uid;
      if (userId == null) {
        log('ℹ️ Skipping token refresh sync: no signed-in user.');
        return;
      }
      try {
        await FirebaseFirestore.instance
            .collection(FirebaseCollections.users)
            .doc(userId)
            .set({
              'fcmToken': token,
              'updatedAt': FieldValue.serverTimestamp(),
            }, SetOptions(merge: true));
        log('✅ Refreshed FCM token synced to backend.');
      } catch (e, st) {
        log('⚠️ Failed syncing refreshed FCM token: $e\n$st');
      }
    });
  }
}
