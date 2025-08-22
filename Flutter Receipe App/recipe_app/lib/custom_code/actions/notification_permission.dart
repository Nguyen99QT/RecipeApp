// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:wakelock_plus/wakelock_plus.dart';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_init.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';

Future notificationPermission() async {
  // Add your function code here!
  // Simplified implementation without permission_handler and wakelock_plus
  print("Notification permission requested (simplified implementation)");
  
  // Request notification permissions for iOS/macOS
  if (Platform.isIOS || Platform.isMacOS) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   if (message.messageId != "") {
//     // DateTime now = DateTime.now();
//
//     // String formattedDate = DateFormat('yyyy-MM-dd').format(now);
//
//     // String formattedTime = DateFormat('hh:mm:ss').format(now);
//
//     // try {
//     //   await NotificationRecord.collection
//     //       .doc()
//     //       .set(createNotificationRecordData(
//     //         title: message.notification!.title,
//     //         description: message.notification!.body,
//     //         image: message.notification!.android!.imageUrl,
//     //         createdAt: formattedTime,
//     //         updatedAt: DateTime.now().toString(),
//     //         createdDate: formattedDate,
//     //         read: false,
//     //       ))
//     //       .then(
//     //     (value) {
//     //       debugPrint("Notification added to Firestore!");
//     //     },
//     //   );
//     // } catch (e) {
//     //   debugPrint("Error adding notification to Firestore: $e");
//     // }
//     debugPrint(
//         "Have received a background message! Will have to grab the message from here somehow if the user didn't interact with the system tray message link");
//   }
//
//   if (Platform.isIOS || Platform.isMacOS) {
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             MacOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//   } else if (Platform.isAndroid) {}
// }
