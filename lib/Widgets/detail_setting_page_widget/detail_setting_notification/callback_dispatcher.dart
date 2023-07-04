// Khởi tạo Workmanager
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

// call funtion show notification
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case "showNotificationTask":
        simpleNotificationShow();
        break;
      default:
        break;
    }
    return Future.value(true);
  });
}

// init notification
Future<void> initNotification() async {
  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings("flutter_logo");
  DarwinInitializationSettings initializationSettingsIos =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    //requestCriticalPermission: true,
    requestSoundPermission: true,
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
      "`It's time to go to sleep let's go to sleep`", notificationDetails);
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
