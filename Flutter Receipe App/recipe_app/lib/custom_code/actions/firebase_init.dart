// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom actions

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'dart:async';
import 'dart:convert';

import 'notification_init.dart';

import 'package:intl/intl.dart';

import 'dart:io' show Platform;

// Future firebaseInit() async {
//   // Add your function code here!
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//
//   // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//
//   FirebaseMessaging.instance.getToken().then((token) {
//     print("Token: $token");
//   });
//
//   // FirebaseMessaging.onMessage.listen((event) {
//   //   Future.delayed(Duration.zero, () {
//   //     flutterLocalNotificationsPlugin.cancelAll();
//   //     _showNotification(event);
//   //   });
//   // });
//   // FirebaseMessaging.onMessageOpenedApp.listen((event) {});
//
//   // FirebaseMessaging.instance.getInitialMessage().then((value) {});
// }

// Future<void> backgroundHandler(RemoteMessage message) async {
//   // await Firebase.initializeApp();
//   // await setupFlutterNotifications();
//
//   Future.delayed(Duration.zero, () {
//     flutterLocalNotificationsPlugin.cancelAll();
//     _showNotification(message);
//   });
// }

// Future<void> _showNotification(RemoteMessage message) async {
//   Map mapData = {
//     "link": message.notification!.android!.link,
//     "action": message.notification!.android!.clickAction,
//     "storyId": message.data["story_id"]
//   };
//
//   String payload = json.encode(mapData);
//   const AndroidNotificationDetails androidNotificationDetails =
//       AndroidNotificationDetails(
//     'be.fit.workout.fitness',
//     'big text channel name',
//     channelDescription: 'big text channel description',
//     importance: Importance.max,
//     priority: Priority.high,
//   );
//
//   // DateTime now = DateTime.now();
//
//   // String formattedDate = DateFormat('yyyy-MM-dd').format(now);
//
//   // String formattedTime = DateFormat('hh:mm:ss').format(now);
//
//   // await NotificationRecord.collection.doc().set(createNotificationRecordData(
//   //       title: message.notification!.title,
//   //       description: message.notification!.body,
//   //       image: message.notification!.android!.imageUrl,
//   //       createdAt: formattedTime,
//   //       updatedAt: DateTime.now().toString(),
//   //       createdDate: formattedDate,
//   //       read: false,
//   //     ));
//
//   const NotificationDetails notificationDetails =
//       NotificationDetails(android: androidNotificationDetails);
//   await flutterLocalNotificationsPlugin.show(1, message.notification!.title,
//       message.notification!.body!, notificationDetails,
//       payload: payload);
//
//   _configureSelectNotificationSubject(message);
//   _configureDidReceiveLocalNotificationSubject(message);
// }

// void _configureDidReceiveLocalNotificationSubject(RemoteMessage message) {
//   didReceiveLocalNotificationStream.stream
//       .listen((ReceivedNotification receivedNotification) async {
//     Map payload = json.decode(receivedNotification.payload!);
//
//     // await Firebase.initializeApp();
//
//     String action = payload["action"];
//
//     // DateTime now = DateTime.now();
//
//     // String formattedDate = DateFormat('yyyy-MM-dd').format(now);
//
//     // String formattedTime = DateFormat('hh:mm:ss').format(now);
//
//     if (action == "FLUTTER_NOTIFICATION_CLICK") {
//       debugPrint(
//           "Notification clicked! by darshan FLUTTER_NOTIFICATION_CLICK 1");
//       // try {
//       //   await NotificationRecord.collection
//       //       .doc()
//       //       .update(createNotificationRecordData(
//       //         title: message.notification!.title,
//       //         description: message.notification!.body,
//       //         image: message.notification!.android!.imageUrl,
//       //         createdAt: formattedTime,
//       //         updatedAt: DateTime.now().toString(),
//       //         createdDate: formattedDate,
//       //         read: true,
//       //       ))
//       //       .then(
//       //     (value) {
//       //       debugPrint("Notification updated to Firestore!");
//       //     },
//       //   );
//       // } catch (e) {
//       //   print("dddddd:$e");
//       // }
//     } else if (action == "FLUTTER_NOTIFICATION_CLICK_STORY") {
//       debugPrint(
//           "Notification clicked! by darshan FLUTTER_NOTIFICATION_CLICK_STORY 1");
//       // try {
//       //   await NotificationRecord.collection
//       //       .doc()
//       //       .update(createNotificationRecordData(
//       //         title: message.notification!.title,
//       //         description: message.notification!.body,
//       //         image: message.notification!.android!.imageUrl,
//       //         createdAt: formattedTime,
//       //         updatedAt: DateTime.now().toString(),
//       //         createdDate: formattedDate,
//       //         read: true,
//       //       ))
//       //       .then(
//       //     (value) {
//       //       debugPrint("Notification updated to Firestore!");
//       //     },
//       //   );
//       // } catch (e) {
//       //   print("dddddd:$e");
//       // }
//     }
//   });
// }
//
// Future<void> _configureSelectNotificationSubject(RemoteMessage message) async {
//   selectNotificationStream.stream.listen((receive) async {
//     Map payload = json.decode(receive!);
//
//     String action = payload["action"];
//
//     // await Firebase.initializeApp();
//
//     // DateTime now = DateTime.now();
//
//     // String formattedDate = DateFormat('yyyy-MM-dd').format(now);
//
//     // String formattedTime = DateFormat('hh:mm:ss').format(now);
//
//     if (action == "FLUTTER_NOTIFICATION_CLICK") {
//       debugPrint(
//           "Notification clicked! by darshan FLUTTER_NOTIFICATION_CLICK 2");
//       //   try {
//       //     await NotificationRecord.collection
//       //         .doc()
//       //         .update(createNotificationRecordData(
//       //           title: message.notification!.title,
//       //           description: message.notification!.body,
//       //           image: message.notification!.android!.imageUrl,
//       //           createdAt: formattedTime,
//       //           updatedAt: DateTime.now().toString(),
//       //           createdDate: formattedDate,
//       //           read: true,
//       //         ))
//       //         .then(
//       //       (value) {
//       //         debugPrint("Notification updated to Firestore!");
//       //       },
//       //     );
//       //   } catch (e) {
//       //     print("dddddd:$e");
//       //   }
//     } else if (action == "FLUTTER_NOTIFICATION_CLICK_STORY") {
//       debugPrint(
//           "Notification clicked! by darshan FLUTTER_NOTIFICATION_CLICK_STORY 2");
//
//       // try {
//       //   await NotificationRecord.collection
//       //       .doc()
//       //       .update(createNotificationRecordData(
//       //         title: message.notification!.title,
//       //         description: message.notification!.body,
//       //         image: message.notification!.android!.imageUrl,
//       //         createdAt: formattedTime,
//       //         updatedAt: DateTime.now().toString(),
//       //         createdDate: formattedDate,
//       //         read: true,
//       //       ))
//       //       .then(
//       //     (value) {
//       //       debugPrint("Notification updated to Firestore!");
//       //     },
//       //   );
//       // } catch (e) {
//       //   print("dddddd:$e");
//       // }
//     }
//   });
//   // }
// }
