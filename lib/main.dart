import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Pages/course_details_page.dart';
import 'package:meditation_app/Pages/detail_music_favorite_page.dart';
import 'package:meditation_app/Pages/detail_setting_page.dart';
import 'package:meditation_app/Pages/music_page.dart';
import 'package:meditation_app/Pages/home_page.dart';
import 'package:meditation_app/Pages/meditate_page.dart';
import 'package:meditation_app/Pages/sleep_page.dart';
import 'package:meditation_app/Pages/user_page.dart';
import 'package:meditation_app/Pages/chooce_topic_page.dart';
import 'package:meditation_app/Pages/get_started_page.dart';
import 'package:meditation_app/Pages/reminders_page.dart';
import 'package:meditation_app/Pages/sign_in_page.dart';
import 'package:meditation_app/Pages/sign_up_page.dart';
import 'package:meditation_app/Pages/signup_or_singin_page.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
  
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(), // Wrap your app
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Meditation App',
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        primaryColor: kColorPrimary,
      ),
      home: const ContainerPage(), // định nghĩa round đầu tiên hiện lên
      routes: {
        '$SingupOrSignin': (_) => const SingupOrSignin(),
        '$SignUp': (_) => const SignUp(),
        '$SignIn': (_) => const SignIn(),
        '$GetstartedPage': (_) => const GetstartedPage(),
        '$ChooseTopicPage': (_) => const ChooseTopicPage(),
        '$RemindersPage': (_) => const RemindersPage(),
        '$ContainerPage': (_) => const ContainerPage(),
        '$HomePage': (_) => const HomePage(),
        '$SleepPage': (_) => const SleepPage(),
        '$MeditatePage': (_) => const MeditatePage(),
        '$MusicPage': (_) => const MusicPage(),
        '$UserAfsarPage': (_) => const UserAfsarPage(),
        '$CourseDetails': (_) => const CourseDetails(),
        '$DetailMusicFavorite': (_) => DetailMusicFavorite(nameSong: '',duration: '',image: '',),
        '$MeditatePage': (_) => const MeditatePage(),
        '$DetailSettingUser': (_) => const DetailSettingUser(),
        //'$AudioFile': (_) => const AudioFile()
      },
    );
  }
}
