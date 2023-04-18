import 'package:flutter/material.dart';
import 'package:meditation_app/Common/widget/appbar_widget.dart';
import 'package:meditation_app/Common/widget/header_widget.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Repository/meditate_storage.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/meditate_page_widget/title_suggest_meditate_widget.dart';
import 'package:meditation_app/Widgets/meditate_page_widget/topic_meditate_widget.dart';
import 'package:meditation_app/Common/widget/reponsive_builder.dart';

final meditateStorage = AssetMeditateStorage();

class MeditatePage extends StatelessWidget {
  const MeditatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      backgroundColor: kColorLightGrey,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: ReponsiveBuilder(
              portrait: Column(
                children: [
                  HeaderWidget(
                    txtHeaderTitle: txtMeditateHeaderTitle,
                    txtHeaderSubTitle: txtMeditateHeaderSubTitle,
                    sTextTitle: 24,
                    sTextSubtitle: 14,
                    colorTextTitle: Colors.black,
                    colorTextSubTitle: kColorDartPrimary,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const AppbarWidget(
                      sBoder: 30,
                      sIcon: 30,
                      sText: 16,
                      colorText: Colors.blue,
                      sWidthImage: 30,
                      sHeightImage: 30,
                      sWidthContainer: 60,
                      sHeightContainer: 60),
                  const TitleSuggestMeditateWidget(),
                  Container(
                    width: size.width,
                    height: size.height,
                    padding: const EdgeInsets.only(top: 15),
                    child: const TopicMeditateWidget(),
                  ),
                ],
              ),
              landscape: Column(
                children: [
                  HeaderWidget(
                    txtHeaderTitle: txtMeditateHeaderTitle,
                    txtHeaderSubTitle: txtMeditateHeaderSubTitle,
                    sTextTitle: 30,
                    sTextSubtitle: 20,
                    colorTextTitle: Colors.black,
                    colorTextSubTitle: kColorDartPrimary,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const AppbarWidget(
                      sBoder: 50,
                      sIcon: 60,
                      sText: 24,
                      colorText: Colors.blue,
                      sWidthImage: 30,
                      sHeightImage: 30,
                      sWidthContainer: 100,
                      sHeightContainer: 100),
                  const TitleSuggestMeditateWidget(),
                  Container(
                    width: size.width,
                    height: size.height,
                    padding: const EdgeInsets.only(bottom: 20, top: 15),
                    child: const TopicMeditateWidget(),
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
