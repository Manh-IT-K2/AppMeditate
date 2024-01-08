import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("Token : $fCMToken");
    initPushNotification();
    initNotification();
  }
}

Future<void> _onBackgroundMessage(RemoteMessage message) async {
  print('title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('payload: ${message.data}');
  // Hiển thị thông báo khi ứng dụng đã bị tắt
}

// Hàm xử lý thông báo từ firebase_messaging
void handleMessage(RemoteMessage message) {
  final data = message.data; // Dữ liệu gửi kèm thông báo từ phía máy chủ
  final wakeUpTime =
      data['sleep']; // Giả sử thời gian thức dậy được gửi dưới dạng chuỗi

  if (wakeUpTime != null) {
    final parts = wakeUpTime.split(':');
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour != null && minute != null) {
      final selectedTime = TimeOfDay(hour: hour, minute: minute);
      scheduleWakeUpNotification(selectedTime);
    }
  }
}

Future initPushNotification() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      handleMessage(message);
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  FirebaseMessaging.onMessage.listen((event) {
    simpleNotificationShow();
  });
}

// init notification
Future<void> initNotification() async {
  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings("flutter_logo");
  DarwinInitializationSettings initializationSettingsIos =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification: (id, title, body, payload) {},
  );
  InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIos,
  );
  await notificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (details) {},
  );
}

// Hàm hiển thị thông báo
Future<void> simpleNotificationShow() async {
  AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails("id", "name",
          priority: Priority.high,
          importance: Importance.max,
          icon: "flutter_logo",
          channelShowBadge: true,
          largeIcon: DrawableResourceAndroidBitmap("flutter_logo"));
  NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  await notificationsPlugin.show(0, "Bedtime Sleep",
      "It's time to go to sleep let's go to sleep", notificationDetails);
}
Future<void> saveNotification(int id, DateTime scheduledTime) async {
  final database = openDatabase(
    await getDatabasesPath() + 'notifications.db',
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE notifications(id INTEGER PRIMARY KEY, scheduledTime TEXT)',
      );
    },
    version: 1,
  );

  final db = await database;
  await db.insert(
    'notifications',
    {'id': id, 'scheduledTime': scheduledTime.toIso8601String()},
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}


Future<void> scheduleWakeUpNotification(TimeOfDay wakeUpTime) async {
  final now = DateTime.now();
  final selectedTime = DateTime(
    now.year,
    now.month,
    now.day,
    wakeUpTime.hour,
    wakeUpTime.minute,
  );

  // Kiểm tra xem thời gian đã chọn đã qua hay chưa
  if (selectedTime.isBefore(now)) {
    // Nếu thời gian đã chọn đã qua, thì tăng ngày lên 1
    selectedTime.add(const Duration(days: 1));
  }

  // Tính thời gian còn lại giữa thời gian đã chọn và hiện tại
  final timeUntilWakeUp = selectedTime.difference(now);
  print("Tính thời gian: $timeUntilWakeUp");
  print("Tính thời gian wakeUpTime: $wakeUpTime");
  print("Tính thời gian selectedTime: $selectedTime");

  // Đặt thông báo thức dậy
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      const AndroidNotificationDetails("id", "name",
          priority: Priority.high,
          importance: Importance.max,
          icon: "flutter_logo",
          channelShowBadge: true,
          largeIcon: DrawableResourceAndroidBitmap("flutter_logo"));

  //final iOSPlatformChannelSpecifics = IOSNotificationDetails();

  final platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    //iOS: iOSPlatformChannelSpecifics,
  );

  await notificationsPlugin.zonedSchedule(
    0,
    'Wake Up',
    'It\'s time to wake up!',
    tz.TZDateTime.utc(selectedTime.year, selectedTime.month, selectedTime.day,
        selectedTime.hour, selectedTime.minute),
    platformChannelSpecifics,
    // ignore: deprecated_member_use
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}

Future<void> sendFCMToTopic(String wakeUpTime) async {
  const String serverKey =
      'AIzaSyB1AEjbQmAWPSU98eiRA1DzJ-mMLpQwkXM'; // Thay YOUR_SERVER_KEY bằng khóa máy chủ của bạn
  const String firebaseApiUrl = 'https://fcm.googleapis.com/fcm/send';

  final Map<String, dynamic> notification = {
    'title': 'Bed Time Sleep',
    'body': 'It\'s time to go to sleep, let\'s go to sleep',
  };

  final Map<String, dynamic> data = {
    'sleep': wakeUpTime,
  };

  final Map<String, dynamic> payload = {
    'notification': notification,
    'data': data,
    'topic': 'sleep',
  };

  try {
    final response = await http.post(
      Uri.parse(firebaseApiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: json.encode(payload),
    );
    print("Nhi cute : ${response.statusCode}");
    if (response.statusCode == 200) {
      print('FCM message sent successfully to topic: meditation_topic');
    } else {
      print('Failed to send FCM message to topic: meditation_topic');
    }
  } catch (e) {
    print('Error sending FCM message to topic: $e');
  }
}
// //
// Future<void> simpleNotificationShow() async {
//   AndroidNotificationDetails androidNotificationDetails =
//       const AndroidNotificationDetails("id", "name",
//           priority: Priority.high,
//           importance: Importance.max,
//           icon: "flutter_logo",
//           channelShowBadge: true,
//           largeIcon: DrawableResourceAndroidBitmap("flutter_logo"));
//   NotificationDetails notificationDetails =
//       NotificationDetails(android: androidNotificationDetails);
//   await notificationsPlugin.show(0, "Bedtime Sleep",
//       "It's time to go to sleep let's go to sleep", notificationDetails);
// }

// //
// Future<void> bigPictureNotificationShow() async {
//   BigPictureStyleInformation bigPictureStyleInformation =
//       const BigPictureStyleInformation(
//     DrawableResourceAndroidBitmap("flutter_logo"),
//     contentTitle: "big city boy",
//     largeIcon: DrawableResourceAndroidBitmap("flutter_logo"),
//   );
//   AndroidNotificationDetails androidNotificationDetails =
//       AndroidNotificationDetails("big_id", "big_name",
//           priority: Priority.high,
//           importance: Importance.max,
//           styleInformation: bigPictureStyleInformation);
//   NotificationDetails notificationDetails =
//       NotificationDetails(android: androidNotificationDetails);
//   await notificationsPlugin.show(0, "Bedtime Sleep",
//       "It's time to go to sleep let's go to sleep", notificationDetails);
// }