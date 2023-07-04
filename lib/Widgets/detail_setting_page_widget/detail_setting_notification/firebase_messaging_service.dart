import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future initialize() async {
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
    FirebaseMessaging.onMessage.listen(_onMessageReceived);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpened);
  }

  Future<void> _onMessageReceived(RemoteMessage message) async {
    print('Received message: ${message.notification?.title}');
    // Hiển thị thông báo khi ứng dụng đang chạy
  }

  Future<void> _onMessageOpened(RemoteMessage message) async {
    print('Message clicked!');
    // Xử lý sự kiện khi thông báo được nhấp vào
  }

  Future<void> _onBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Background message: ${message.notification?.title}');
    // Hiển thị thông báo khi ứng dụng đã bị tắt
  }
  
}
