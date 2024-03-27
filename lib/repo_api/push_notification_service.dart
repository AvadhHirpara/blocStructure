import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../utils/app_constants.dart';
import '../utils/shared_preference_util.dart';


/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

///background notification handler..
Future<dynamic> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

/// Handle the clicked notification.
Future<void> handleNotification(Map<String, dynamic> data, {bool delay = false}) async {
  if (Platform.isIOS) {
    //IOS related
  } else {}
}

void notificationTapBackground(NotificationResponse notificationResponse) {

}

final StreamController<ReceivedNotification> didReceiveLocalNotificationStream = StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream = StreamController<String?>.broadcast();

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

class PushNotificationService {
  dynamic message;

  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();

    saveFcmToken();

    // This function is called when the app is in the background and user clicks on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      this.message = message.data;
      // ToDo:: Notification tap event
       handleNotification(message.data, messageData: message);
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message?.data.isNotEmpty ?? false) {
        Future.delayed(const Duration(seconds: 1)).then((value) => handleNotification(message!.data, messageData: message));
      }
    });

    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: false,
      sound: true,
    );
    await registerNotificationListeners();
  }

  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var androidSettings = const AndroidInitializationSettings('@drawable/ic_notification');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationStream.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      },
    );

    var initSettings = InitializationSettings(android: androidSettings, iOS: initializationSettingsDarwin);

    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.add(notificationResponse.payload);
            }
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message?.notification;

      if (notification != null) {
        debugPrint('Message also contained a notification: ${notification.title}');
        if (Platform.isAndroid) {
          _showLocalNotification(
            title: notification.title ?? '',
            body: notification.body ?? '',
          );
        }
      }
    });
  }

  androidNotificationChannel() => const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.',
        // description
        importance: Importance.max,
      );



  /// Handle the clicked notification.
  Future<void> handleNotification(Map<String, dynamic> data, {bool delay = false, RemoteMessage? messageData}) async {
     // RemoteNotification? notification = messageData!.notification;
    // AndroidNotification? android = messageData.notification?.android;

    message = data;

  }

  saveFcmToken() async {

    String? fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint("fcmToken ==> $fcmToken");

    SharedPreferenceUtil.putValue(fcmTokenKey, '$fcmToken');

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      // Save newToken
      SharedPreferenceUtil.putValue(fcmTokenKey, newToken);
    });
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> _showLocalNotification({required String title, required String body}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosPlatformChannelSpecifics = DarwinNotificationDetails(
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  Future<void> clearNotification(String id) async {

    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
