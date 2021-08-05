import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@drawable/logo_white");

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(
      int id, String title, String body, int seconds) async {
    print("id: " "$id");
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'main_channel', 'Main Channel', "Main Channel notification",
              importance: Importance.max,
              priority: Priority.max,
              icon: "@drawable/logo_white"),
          iOS: IOSNotificationDetails(
              sound: "default.wav",
              presentAlert: true,
              presentBadge: true,
              presentSound: true)),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: "BILET",
    );
  }

  // setOnNotificationClick(Function onNotificationClick) async {
  //   await flutterLocalNotificationsPlugin.initialize(,
  //       onSelectNotification: (String payload) async {
  //     onNotificationClick(payload);
  //   });
  // }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  // Future<void> onTapNotification(int id) async {
  //   await flutterLocalNotificationsPlugin.
  // }
}
