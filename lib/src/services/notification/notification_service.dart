import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:green_wheels/theme/colors.dart';

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;

  final _localNotifcations = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    //Request Permission
    await _requestPermission();

    //Setup message handlers
    await _setupMessageHandlers();

    //Get FCM token
    final token = await _messaging.getToken();
    log("$token", name: "FCM Token");
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );

    log(
      "${settings.authorizationStatus}",
      name: "Firebase Messaging Permission Status",
    );
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) return;

    const channel = AndroidNotificationChannel(
      "high_importance_channel",
      "High Importance Notifications",
      description: "This Channel is used for important notifications",
      playSound: true,
      ledColor: kPrimaryColor,
      importance: Importance.high,
    );

    await _localNotifcations
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/launcher_icon");

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      // ...
      notificationCategories: [
        DarwinNotificationCategory(
          'Category1',
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain('id_1', 'Action 1'),
            DarwinNotificationAction.plain(
              'id_2',
              'Action 2',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.destructive,
              },
            ),
            DarwinNotificationAction.plain(
              'id_3',
              'Action 3',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.foreground,
              },
            ),
          ],
          options: <DarwinNotificationCategoryOption>{
            DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
          },
        )
      ],
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _localNotifcations.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (details) {},
      onDidReceiveNotificationResponse: (details) {},
    );

    _isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;

    AndroidNotification? androidNotification = message.notification?.android;
    if (notification != null && androidNotification != null) {
      await _localNotifcations.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            "high_importance_channel",
            "High Importance Notifications",
            channelDescription:
                "This channel is used for important notifications",
            importance: Importance.high,
            priority: Priority.high,
            icon: "@mipmap/launcher_icon",
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  Future<void> _setupMessageHandlers() async {
    //Foregound message
    FirebaseMessaging.onMessage.listen(
      (message) {
        showNotification(message);
      },
    );

    //Background message
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
    return;
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    if (message.data['type'] == "ride_started") {}
  }
}
