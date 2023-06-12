import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/course_detail_page_widget/appbar_course_detail_widget.dart';
import 'package:meditation_app/Widgets/course_detail_page_widget/body_course_detail_widget.dart';
import 'package:meditation_app/Widgets/course_detail_page_widget/header_course_detail_widget.dart';
import 'package:meditation_app/Widgets/course_detail_page_widget/record_course_detail_widget.dart';
import 'package:meditation_app/Common/widget/reponsive_builder.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({super.key});

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
                child: const Column(
                  children: [
                    HeaderCourseDetailWidget(),
                    RecordCourseDetailWidget(),
                    DefaultTabController(
                      length: 2,
                      child: Expanded(child: BodyCourseDetailWidget()),
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
                      child: const Column(
                        children: [
                          HeaderCourseDetailWidget(),
                          RecordCourseDetailWidget(),
                        ],
                      ),
                    ),
                    const DefaultTabController(
                      length: 2,
                      child: Expanded(child: BodyCourseDetailWidget()),
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
