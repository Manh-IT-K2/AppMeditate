import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/course_detail_page_widget/TabBar/relaxjazz_tabbar_widget.dart';
import 'package:meditation_app/Widgets/course_detail_page_widget/TabBar/relaxpiano_tabbar_widget.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:meditation_app/model/musics_model.dart';

// ignore: must_be_immutable
class BodyCourseDetailWidget extends StatelessWidget {
  BodyCourseDetailWidget({
    super.key,
    required this.futureOne,
    required this.futureTwo,
    required this.titleOne,
    required this.titleTwo,
  });

  String titleOne, titleTwo;
  Future<List<MusicsModel>> futureOne, futureTwo;
  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 30),
          child: Text(
            translation(context).txtCourseDetailBodyTitle,
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
                   titleOne,
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
                    titleTwo,
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
        Flexible(
          flex: 1,
          child: TabBarView(
            children: [
              RelaxPianoWidget(future: futureOne,),
              RelaxJazzWidget(future: futureTwo,),
            ],
          ),
        ),
      ],
    );
  }
}
