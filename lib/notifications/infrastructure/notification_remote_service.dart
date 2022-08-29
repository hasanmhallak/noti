// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'firebase_options.dart';

export 'package:firebase_messaging_platform_interface/src/remote_message.dart';
export 'package:firebase_messaging_platform_interface/src/remote_notification.dart';

class NotificationRemoteService {
  /// Initializes firebase app after insuring that [WidgetsBinding]
  /// is properly initialized.
  ///
  /// This should be call whenever tha app start. for instance
  /// on notifications click.
  Future<void> insureInitialization() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: FirebaseDefaultOptions.currentPlatform,
    );
    await FirebaseMessaging.instance.subscribeToTopic('all');
  }

  /// Prompts the user for notification permissions.
  ///
  ///  - On iOS, a dialog is shown requesting the users permission.
  ///  - On Android, a [NotificationSettings] class will be returned with the
  ///    value of [NotificationSettings.authorizationStatus] indicating whether
  ///    the app has notifications enabled or blocked in the system settings.
  Future<bool> requestPermission() async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  /// Returns the default FCM token for this device.
  Future<String?> getToken() async {
    try {
      return FirebaseMessaging.instance.getToken();
    } catch (_) {
      return null;
    }
  }

  /// Returns a [Stream] that is called when a user presses a notification message displayed
  /// via FCM.
  ///
  /// A Stream event will be sent if the app has opened from a background state
  /// (not terminated).
  ///
  /// If your app is opened via a notification whilst the app is terminated,
  /// see [getInitialMessage].
  Stream<RemoteMessage> get onMessageOpenedApp =>
      FirebaseMessaging.onMessageOpenedApp;

  /// Returns a Stream that is called when an incoming FCM payload is received whilst
  /// the Flutter instance is in the foreground.
  ///
  /// The Stream contains the [RemoteMessage].
  ///
  /// To handle messages whilst the app is in the background or terminated,
  /// see [onBackgroundMessage].
  Stream<RemoteMessage> get onMessage => FirebaseMessaging.onMessage;

  /// Set a message handler function which is called when the app is in the
  /// background or terminated.
  ///
  /// This provided handler must be a top-level function and cannot be
  /// anonymous otherwise an [ArgumentError] will be thrown.
  void onBackgroundMessage(
          Future<void> Function(RemoteMessage message) handler) =>
      FirebaseMessaging.onBackgroundMessage(handler);

  /// After this you have two options:
  ///
  ///* Create a channel with the default id you already defined in
  /// AndroidManifest.xml
  ///* Choose your own channel ids and send each notification to a specific channel
  /// by embedding the channel id into your FCM notification message. To do so,
  /// add channel_id tag to your notification under notification tag,
  /// under android tag.
  ///
  /// Example:
  /// ```dart
  ///    'notification': {
  ///      'title': your_title,
  ///      'body': your_body,
  ///  },
  ///  'android': {
  ///     'notification': {
  ///         'channel_id': your_channel_id,
  ///     },
  /// },
  /// ```
  Future<void> registerNotificationChannel() async {
    final noti = FlutterLocalNotificationsPlugin();
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = IOSInitializationSettings();
    const initSetting =
        InitializationSettings(android: androidInit, iOS: iosInit);

    await noti.initialize(initSetting);
    const androidNotificationChannel = AndroidNotificationChannel(
      'push',
      'Pushlol',
      description: 'Receive a push lol noti',
      importance: Importance.max,
      enableLights: true,
      ledColor: Colors.red,
    );
    await noti
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }
}
