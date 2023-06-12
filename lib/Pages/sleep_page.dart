import 'package:flutter/material.dart';
import 'package:meditation_app/Common/widget/appbar_widget.dart';
import 'package:meditation_app/Common/widget/header_widget.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Common/widget/reponsive_builder.dart';
import 'package:meditation_app/Widgets/sleep_page_widget/title_suggets_sleep_widget.dart';
import 'package:meditation_app/Widgets/sleep_page_widget/topic_sleep_widget.dart';

class SleepPage extends StatelessWidget {
  const SleepPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      backgroundColor: const Color(0xFF1F265E),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: SingleChildScrollView(
            child: ReponsiveBuilder(
              portrait: Column(
                children: [
                  HeaderWidget(
                      sTextTitle: 24,
                      sTextSubtitle: 14,
                      colorTextTitle: Colors.white,
                      colorTextSubTitle: Colors.white,
                      txtHeaderTitle: txtSleepHeaderTitle,
                      txtHeaderSubTitle: txtSleepHeaderSubTitle),
                  const SizedBox(
                    height: 20,
                  ),
                  const AppbarWidget(
                      sBoder: 30,
                      sIcon: 30,
                      sText: 16,
                      colorText: Colors.white,
                      sWidthImage: 30,
                      sHeightImage: 30,
                      sWidthContainer: 60,
                      sHeightContainer: 60),
                  TitleSuggetWidget(
                    sIcon: 20,
                    sTextTitle: 20,
                    sTextSubTitle: 14,
                    sWidthImage: size.width,
                    sBoderIcon: 30,
                    sHeightIcon: 35,
                    sWidthIcon: 35,
                    sHeightButton: 40,
                    sWidthButton: 85,
                  ),
                  Container(
                    width: size.width,
                    height: size.height,
                    padding: const EdgeInsets.only(top: 20),
                    child: const TopicSleepWidget(
                      sTextTitle: 14,
                      sTextSubtitle: 10,
                    ),
                  ),
                ],
              ),
              landscape: Column(
                children: [
                  HeaderWidget(
                      sTextTitle: 30,
                      sTextSubtitle: 20,
                      colorTextTitle: Colors.white,
                      colorTextSubTitle: Colors.white,
                      txtHeaderTitle: txtSleepHeaderTitle,
                      txtHeaderSubTitle: txtSleepHeaderSubTitle),
                  const SizedBox(
                    height: 20,
                  ),
                  const AppbarWidget(
                      sBoder: 50,
                      sIcon: 60,
                      sText: 24,
                      colorText: Colors.white,
                      sWidthImage: 60,
                      sHeightImage: 60,
                      sWidthContainer: 100,
                      sHeightContainer: 100),
                  TitleSuggetWidget(
                    sIcon: 60,
                    sTextTitle: 40,
                    sTextSubTitle: 20,
                    sWidthImage: size.width,
                    sBoderIcon: 40,
                    sHeightIcon: 80,
                    sWidthIcon: 80,
                    sHeightButton: 80,
                    sWidthButton: 200,
                  ),
                  Container(
                    width: size.width,
                    height: size.height,
                    padding: const EdgeInsets.only(top: 20),
                    child: const TopicSleepWidget(
                      sTextTitle: 14,
                      sTextSubtitle: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
