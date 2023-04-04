import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/course_detail_page_widget/TabBar/female_tabbar_widget.dart';
import 'package:meditation_app/Widgets/course_detail_page_widget/TabBar/fovorite_tabbar_widget.dart';
import 'package:meditation_app/Widgets/course_detail_page_widget/TabBar/male_tabbar_widget.dart';

class BodyCourseDetailWidget extends StatelessWidget {
  const BodyCourseDetailWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 20),
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
              ),),
            ),
            unselectedLabelColor: kColorDartPrimary,
            isScrollable: true,
            labelColor: kColorPrimary,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            tabs: [
              Tab(
                child: Text(
                  txtCourseDetailTabbarTitle1,
                  style: const TextStyle(
                    fontFamily: 'HelveticaNeue',
                  ),
                  //style: Primaryfont.medium(24).copyWith(color: Color(0xFF8E97FD)),
                ),
              ),
              Tab(
                child: Text(
                  txtCourseDetailTabbarTitle2,
                  style: const TextStyle(
                    fontFamily: 'HelveticaNeue',
                    fontSize: 14,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  txtCourseDetailTabbarTitle3,
                  style: const TextStyle(
                    fontFamily: 'HelveticaNeue',
                    fontSize: 14,
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
              MaleTabbarWidget(),
              FemaleTabbarWidget(),
              FavoriteTabbarWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
