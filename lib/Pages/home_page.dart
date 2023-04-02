import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/home_page_widget/body_one_home_widget.dart';
import 'package:meditation_app/Widgets/home_page_widget/body_two_home_widget.dart';
import 'package:meditation_app/Widgets/home_page_widget/footer_home_widget.dart';
import 'package:meditation_app/Widgets/home_page_widget/header_home_widget.dart';
import 'package:meditation_app/Widgets/reponsive_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      backgroundColor: kColorLightGrey,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SingleChildScrollView(
          child: SafeArea(
            child: ReponsiveBuilder(
              portrait: Column(
                children: [
                  const HeaderHomeWidget(
                    sTextSubTitle: 14,
                    sTextTitle: 24,
                    sImgWidth: 200,
                  ),
                  BodyHomeWidgetOne(
                    sWidth: size.width * 0.45,
                    sHeight: size.height * 0.25,
                    pLeft: 17,
                    aLeft: -0.55,
                    sbWidth: 20,
                  ),
                  BodyHomeWidgetTwo(
                    sHeight: size.height * 0.093,
                    sWidth: size.width,
                  ),
                  const FooterHomeWidget(
                      imgHeight: 220,
                      imgWidth: 180,
                      sTextHeader: 24,
                      sTextSubTitle: 10,
                      sTextTitle: 18,
                      sbWidth: 180,
                      sContainerHeight: 220),
                ],
              ),
              landscape: Column(
                children: [
                  const HeaderHomeWidget(
                    sTextSubTitle: 18,
                    sTextTitle: 30,
                    sImgWidth: 250,
                  ),
                  BodyHomeWidgetOne(
                    sWidth: size.width * 0.42,
                    sHeight: size.height * 0.55,
                    pLeft: 41,
                    aLeft: -0.70,
                    sbWidth: 150,
                  ),
                  BodyHomeWidgetTwo(
                    sHeight: size.height * 0.25,
                    sWidth: size.width,
                  ),
                  const FooterHomeWidget(
                      imgHeight: 235,
                      imgWidth: 235,
                      sTextHeader: 30,
                      sTextSubTitle: 14,
                      sTextTitle: 24,
                      sbWidth: 235,
                      sContainerHeight: 235),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
