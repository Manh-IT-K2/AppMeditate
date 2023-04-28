import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/home_page.dart';
import 'package:meditation_app/Pages/meditate_page.dart';
import 'package:meditation_app/Pages/music_page.dart';
import 'package:meditation_app/Pages/sleep_page.dart';
import 'package:meditation_app/Pages/user_page.dart';

class ContainerPage extends StatefulWidget {
  const ContainerPage({super.key});

  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  int _selectIndex = SaveChange.indexPage;
  void _navigateBottombar(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  final List<Widget> _pages = [
    const SleepPage(),
    const MeditatePage(),
    const HomePage(),
    const MusicPage(),
    const UserAfsarPage()
  ];

  @override
  Widget build(BuildContext context) {
    //final size = context.screenSize;
    return Scaffold(
      backgroundColor:
          _selectIndex == 0 ? const Color(0xFF1F265E) : kColorLightGrey,
      body: SafeArea(child: _pages[_selectIndex]),
      bottomNavigationBar: CurvedNavigationBar(
        height: 75,
        backgroundColor:
            _selectIndex == 0 ? const Color(0xFF1F265E) : kColorLightGrey,
        color: Colors.white,
        onTap: _navigateBottombar,
        //animationCurve: Curves.fastLinearToSlowEaseIn,
        animationDuration: const Duration(milliseconds: 400),
        index: _selectIndex,
        items: [
          Image.asset(
            imgContainerSleep,
          ),
          Image.asset(
            imgContainerMeditate,
          ),
          Image.asset(
            imgContainerHome,
          ),
          Image.asset(
            imgContainerMusic,
          ),
          Image.asset(
            imgContainerUser,
          ),
        ],
      ),
    );
  }
}

// change switch and index page
class SaveChange {
  static final userName = Get.arguments ?? "";
  static List<bool> changeSwitch = [false, false];
  static int indexPage = 2;
}
