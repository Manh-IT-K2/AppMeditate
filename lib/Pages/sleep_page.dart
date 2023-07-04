import 'package:flutter/material.dart';
import 'package:meditation_app/Common/widget/header_circle_widget.dart';
import 'package:meditation_app/Common/widget/header_widget.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Common/widget/reponsive_builder.dart';
import 'package:meditation_app/Widgets/sleep_page_widget/title_suggets_sleep_widget.dart';
import 'package:meditation_app/Widgets/sleep_page_widget/topic_sleep_widget.dart';
import 'package:meditation_app/controller/language_controller.dart';

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
          child: ReponsiveBuilder(
            portrait: Stack(
              children: [
                HeaderWidget(
                    sTextTitle: 24,
                    sTextSubtitle: 14,
                    colorTextTitle: Colors.white,
                    colorTextSubTitle: Colors.white,
                    txtHeaderTitle: translation(context).txtSleepHeaderTitle,
                    txtHeaderSubTitle:
                        translation(context).txtSleepHeaderSubTitle),
                const SizedBox(
                  height: 20,
                ),
                const HeaderCircleWidget(
                  color: Color.fromARGB(255, 52, 64, 153),
                ),
                Positioned.fill(
                  top: 180,
                  child: Column(
                    children: [
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
                      SingleChildScrollView(
                        child: Container(
                          width: size.width,
                          height: size.height * 0.3,
                          padding: const EdgeInsets.only(top: 20),
                          child: const TopicSleepWidget(
                            sTextTitle: 14,
                            sTextSubtitle: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            landscape: Stack(
              children: [
                HeaderWidget(
                    sTextTitle: 30,
                    sTextSubtitle: 20,
                    colorTextTitle: Colors.white,
                    colorTextSubTitle: Colors.white,
                    txtHeaderTitle: translation(context).txtSleepHeaderTitle,
                    txtHeaderSubTitle:
                        translation(context).txtSleepHeaderSubTitle),
                const SizedBox(
                  height: 20,
                ),
                const HeaderCircleWidget(
                  color: Color.fromARGB(255, 52, 64, 153),
                ),
                Positioned.fill(
                  top: 180,
                  child: Column(
                    children: [
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
                      SingleChildScrollView(
                        child: Container(
                          width: size.width,
                          height: size.height * 0.5,
                          padding: const EdgeInsets.only(top: 20),
                          child: const TopicSleepWidget(
                            sTextTitle: 14,
                            sTextSubtitle: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
