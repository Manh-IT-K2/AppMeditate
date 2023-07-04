import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/signup_or_singin_page.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/detail_setting_page_widget/detail_setting_notification/callback_dispatcher.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:meditation_app/controller/statistical_controller.dart';
import 'package:meditation_app/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Workmanager().initialize(callbackDispatcher);
  Workmanager().registerPeriodicTask(
    "showNotification", // Tên công việc
    "showNotificationTask", // Tên task
    frequency: const Duration(hours: 1), // Tần suất chạy công việc
  );
  // final firebaseMessagingService = FirebaseMessagingService();
  // await firebaseMessagingService.initialize();
  // final notificationService = NotificationService();
  // await notificationService.initialize();
  // await FirebaseMessaging.instance.setAutoInitEnabled(true);
  // //final fcmToken = await FirebaseMessaging.instance.getToken();
  // FirebaseMessaging.instance.onTokenRefresh
  // .listen((fcmToken) { })
  // .onError((err){});
  //print("token : $fcmToken");
  // Firebase.initializeApp(
  //   options:const FirebaseOptions(
  // apiKey: 'AIzaSyB1AEjbQmAWPSU98eiRA1DzJ-mMLpQwkXM',
  // appId: '1:928203370994:android:8713ccfb1d13b6b4353b6b',
  // messagingSenderId: '928203370994',
  // projectId: 'meditate-app-e19c8',
  // storageBucket: 'meditate-app-e19c8.appspot.com',
  //   apiKey: 'AIzaSyATC4BjRaO5JVSGwnQLuzFVCxYGEokDCkI',
  //   appId: '1:928203370994:web:434a8778b8164f44353b6b',
  //   messagingSenderId: '928203370994',
  //   projectId: 'meditate-app-e19c8',
  //   authDomain: 'meditate-app-e19c8.firebaseapp.com',
  //   storageBucket: 'meditate-app-e19c8.appspot.com',
  //   measurementId: 'G-SWG713JHD6',
  // ));
  // get info login
  ConnectivityResult connectivityResult =
      await (Connectivity().checkConnectivity());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn, connectivityResult: connectivityResult)
      //   DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) =>
      //       MyApp(isLoggedIn: isLoggedIn, connectivityResult: connectivityResult),
      // )
      );
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  ConnectivityResult connectivityResult;
  final bool isLoggedIn;
  MyApp({Key? key, required this.isLoggedIn, required this.connectivityResult})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale){
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale){
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies(){
    getLocale().then((locale) => setLocale(locale));
    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    final controllerStatistical = Get.put(StatisticalController());
    // Ghi lại sự kiện khi người dùng xoá ứng dụng
    void handleAppRemove() {
      FirebaseAnalytics.instance.logEvent(name: 'user_app_remove');
      // Gọi hàm xoá người dùng khỏi Firestore
      controllerStatistical.deleteFullByUserId();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleAppRemove();
    });

    final size = context.screenSize;
    if (widget.connectivityResult == ConnectivityResult.none) {
      return MaterialApp(
        home: Container(
          color: Colors.white,
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              GifView.asset(
                imgConnetionInternet,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () async {
                  ConnectivityResult connectivityResult =
                      await (Connectivity().checkConnectivity());
                  runApp(MyApp(
                          isLoggedIn: widget.isLoggedIn,
                          connectivityResult: connectivityResult)
                      // DevicePreview(
                      //   enabled: !kReleaseMode,
                      //   builder: (context) => MyApp(
                      //       isLoggedIn: isLoggedIn,
                      //       connectivityResult: connectivityResult),
                      // ),
                      );
                },
                child: Text(
                  translation(context).txtTryAgain,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (widget.connectivityResult == ConnectivityResult.mobile ||
        widget.connectivityResult == ConnectivityResult.wifi) {
      if (widget.isLoggedIn) {
        return GetMaterialApp(
          title: 'Meditation',
          locale: _locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          theme: ThemeData(
            primaryColor: kColorPrimary,
          ),
          home: const ContainerPage(), // định nghĩa round đầu tiên hiện lên
          // routes: {
          //   '$SingupOrSignin': (_) => const SingupOrSignin(),

          // },
        );
      } else {
        return GetMaterialApp(
          title: 'Meditation',
          locale: _locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          theme: ThemeData(
            primaryColor: kColorPrimary,
          ),
          home: const SingupOrSignin(), // định nghĩa round đầu tiên hiện lên
        );
      }
    } else {
      return const SizedBox();
    }
  }
}
