// // import 'dart:io';

// // import 'package:firebase_messaging/firebase_messaging.dart';

// // class PushNotificationService {

// //   Future initialise()async{
// //     is(Platform.isIOS){
// //       FirebaseMessaging.reque
// //     }
// //   }
// // }

// import 'dart:io';

// import 'package:event_app/model/receivedNotifi.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/rxdart.dart';

// class NotificationHelper {
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   final BehaviorSubject<ReceivedNotification>
//       didReceivedLocalNotificationSubject =
//       BehaviorSubject<ReceivedNotification>();
//   var notificationSettings;

//   init() async {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     if (Platform.isIOS) {
//       _requestIOSPermission();
//     }
//     initializePlatform();
//   }

//   _requestIOSPermission() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()!
//         .requestPermissions(
//           alert: false,
//           badge: true,
//           sound: true,
//         );
//   }

//   initializePlatform() {
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//     var initializationSettingsIOS = IOSInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: false,
//       onDidReceiveLocalNotification: (id, title, body, payload) async {
//         ReceivedNotification receivedNotification = ReceivedNotification(
//             id: id, title: title, body: body, payload: payload);
//         didReceivedLocalNotificationSubject.add(receivedNotification);
//       },
//     );
//   }
// }
