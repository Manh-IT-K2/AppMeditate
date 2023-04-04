import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Pages/course_details_page.dart';
import 'package:meditation_app/Pages/detail_music_page.dart';
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

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(), // Wrap your app
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meditation App',
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        primaryColor: kColorPrimary,
      ),
      initialRoute: '$SingupOrSignin',// định nghĩa round đầu tiên hiện lên
      routes: {
        '$SingupOrSignin': (_) => const SingupOrSignin(),
        '$SignUp': (_) => const SignUp(),
        '$SignIn': (_) => SignIn(),
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
        '$DetailMusic': (_) => DetailMusic(nameSong: '', duration: '', image: '',), 
        '$MeditatePage': (_) => const MeditatePage(),
        '$DetailSettingUser': (_) => const DetailSettingUser(),
      },
    );
  }
}
