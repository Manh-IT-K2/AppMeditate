import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/course_detail_page_widget/appbar_course_detail_widget.dart';
import 'package:meditation_app/Widgets/course_detail_page_widget/body_course_detail_widget.dart';
import 'package:meditation_app/Widgets/course_detail_page_widget/header_course_detail_widget.dart';
import 'package:meditation_app/Widgets/course_detail_page_widget/record_course_detail_widget.dart';
import 'package:meditation_app/Common/widget/reponsive_builder.dart';
import 'package:meditation_app/model/musics_model.dart';

// ignore: must_be_immutable
class CourseDetails extends StatelessWidget {
  CourseDetails({
    super.key,
    required this.titleOne,
    required this.titleTwo,
    required this.titleDetail,
    required this.subTitleDetail,
    required this.futureOne,
    required this.futureTwo,
    required this.futureListen,
    required this.futureFavourite,
  });

  String titleOne, titleTwo, titleDetail, subTitleDetail;
  Future<List<MusicsModel>> futureOne, futureTwo;
  Future<int?> futureListen, futureFavourite;
  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      backgroundColor: kColorLightGrey,
      body: SingleChildScrollView(
        child: ReponsiveBuilder(
          portrait: Column(
            children: [
              const AppbarCourseDetailWidget(),
              Container(
                width: size.width,
                height: size.height,
                padding: const EdgeInsets.only(
                    bottom: 20, left: 20, right: 20, top: 50),
                child: Column(
                  children: [
                    HeaderCourseDetailWidget(title: titleDetail, subTitle: subTitleDetail,),
                    RecordCourseDetailWidget(futureListten: futureListen,futureFavourite: futureFavourite,),
                    DefaultTabController(
                      length: 2,
                      child: Expanded(child: BodyCourseDetailWidget(
                        titleOne: titleOne,
                        titleTwo: titleTwo,
                        futureOne: futureOne,
                        futureTwo: futureTwo,
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
          landscape: Column(
            children: [
              AppbarCourseDetailWidget(
                sWidthIamge: size.width,
                sHeightImage: size.height * 0.4,
              ),
              Container(
                width: size.width,
                height: size.height,
                padding: const EdgeInsets.only(
                    bottom: 20, left: 20, right: 70, top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 50, right: 100, top: 20),
                      child: Column(
                        children: [
                          HeaderCourseDetailWidget(title: titleDetail, subTitle: subTitleDetail,),
                          RecordCourseDetailWidget(futureListten: futureListen,futureFavourite: futureFavourite,),
                        ],
                      ),
                    ),
                    DefaultTabController(
                      length: 2,
                      child: Expanded(child: BodyCourseDetailWidget(
                        titleOne: titleOne,
                        titleTwo: titleTwo,
                        futureOne: futureOne,
                        futureTwo: futureTwo,
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
