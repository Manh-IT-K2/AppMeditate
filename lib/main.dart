import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:meditation_app/Page/ContainerPage.dart';
import 'package:meditation_app/Page/course_details_page.dart';
import 'package:meditation_app/Page/music_page.dart';
import 'package:meditation_app/Page/detail_favorite.dart';
import 'package:meditation_app/Page/detail_setting.dart';
import 'package:meditation_app/Page/home_page.dart';
import 'package:meditation_app/Page/meditate_page.dart';
import 'package:meditation_app/Page/music_page.dart';
import 'package:meditation_app/Page/sleep_page.dart';
import 'package:meditation_app/Page/user_page.dart';
import 'package:meditation_app/Page/chooce_topic_page.dart';
import 'package:meditation_app/Page/get_started_page.dart';
import 'package:meditation_app/Page/reminders_page.dart';
import 'package:meditation_app/Page/sign_in_page.dart';
import 'package:meditation_app/Page/sign_up_page.dart';
import 'package:meditation_app/Page/signup_or_singin_page.dart';
import 'package:meditation_app/Utils/theme.dart';


void main() {
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
        '$SignIn': (_) => const SignIn(),
        '$GetstartedPage': (_) => const GetstartedPage(),
        '$ChooseTopicPage': (_) => const ChooseTopicPage(),
        '$RemindersPage': (_) => const RemindersPage(),
        '$ContainerPage': (_) => const ContainerPage(),
        '$HomePage': (_) => const HomePage(),
        '$SleepPage': (_) =>  SleepPage(),
        '$MeditatePage': (_) => const MeditatePage(),
        '$MusicPage': (_) => const MusicPage(),
        '$UserAfsarPage': (_) => const UserAfsarPage(),
        '$CourseDetails': (_) => const CourseDetails(),
        '$DetailFavorite': (_) =>  DetailFavorite(nameSong: '',), 
        '$MeditatePage': (_) => const MeditatePage(),
        '$DetailSettingUser': (_) => const DetailSettingUser(),
      },
    );
  }
}
