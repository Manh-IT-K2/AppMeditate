import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/course_detail_page_widget/TabBar/relaxjazz_tabbar_widget.dart';
import 'package:meditation_app/Widgets/course_detail_page_widget/TabBar/relaxpiano_tabbar_widget.dart';

class BodyCourseDetailWidget extends StatelessWidget {
  const BodyCourseDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 30),
          child: Text(
            txtCourseDetailBodyTitle,
            style: Primaryfont.ligh(24).copyWith(color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 0),
          child: TabBar(
            //indicatorSize: TabBarIndicatorSize.label,
            indicator: const BoxDecoration(
              //borderRadius: BorderRadius.circular(30),
              color: kColorLightGrey,
              border: Border(
                bottom: BorderSide(
                  color: kColorPrimary,
                  width: 2,
                ),
              ),
            ),
            unselectedLabelColor: kColorDartPrimary,
            isScrollable: true,
            labelColor: kColorPrimary,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            tabs: [
              SizedBox(
                width: size.width/3,
                child: Tab(
                  child: Text(
                    txtCourseDetailTabbarTitle1,
                    style: const TextStyle(
                      fontFamily: 'HelveticaNeue',
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width/3,
                child: Tab(
                  child: Text(
                    txtCourseDetailTabbarTitle2,
                    style: const TextStyle(
                      fontFamily: 'HelveticaNeue',
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Flexible(
          flex: 1,
          child: TabBarView(
            children: [
              RelaxPianoWidget(),
              RelaxJazzWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
