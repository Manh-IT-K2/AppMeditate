import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/course_details_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:meditation_app/controller/music_controller.dart';
import 'package:meditation_app/controller/statistical_controller.dart';

class BodyHomeWidgetOne extends StatelessWidget {
  const BodyHomeWidgetOne({
    super.key,
    required this.sWidth,
    required this.sHeight,
    required this.pLeft,
    required this.aLeft,
    required this.sbWidth,
  });

  final double sHeight, sWidth, pLeft, aLeft, sbWidth;

  @override
  Widget build(BuildContext context) {
    final contronller = Get.put(MusicController());
    final controllerStatistical = Get.put(StatisticalController());
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 12, right: 12, bottom: 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF8E97FD),
            ),
            width: sWidth,
            height: sHeight,
            // color: Color(0xFF8E97FD),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                    ),
                    child: Image.asset(
                      imgHomeBgBasic,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.70, 0.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'English\n',
                      style: Primaryfont.bold(20).copyWith(
                        color: kColorLightYellow,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'PODCAST',
                          style: Primaryfont.bold(10)
                              .copyWith(color: kColorLightYellow),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: pLeft, top: 20),
                  child: Row(
                    children: [
                      Text(
                        '10-30 ${translation(context).txtMin}',
                        style: Primaryfont.medium(12)
                            .copyWith(color: kColorLightGrey),
                      ),
                      SizedBox(
                        width: sbWidth,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       SaveChange.indexPage = 2;
                          //       return const CourseDetails();
                          //     },
                          //   ),
                          // );
                         
                         
                         Get.to(() => CourseDetails(
                          titleDetail: translation(context).txtCourseDetailHeaderSubTitle3,
                          subTitleDetail: translation(context).txtCourseDetailHeaderSubTitle4,
                          titleOne: translation(context).txtCourseDetailTabbarTitle3, 
                          titleTwo: translation(context).txtCourseDetailTabbarTitle4, 
                          futureListen: controllerStatistical.getTotalViewEnglishPodcast(),
                          futureFavourite: controllerStatistical.getTotalFavouriteEnglishPodcast(),
                          futureOne: contronller.getMusicMeditationPodcastMaleVoice(),
                          futureTwo:  contronller.getMusicMeditationPodcastFemaleVoice(),
                          ),
                          );
                        },
                        color: Colors.white,
                        height: 40,
                        minWidth: 54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(38),
                        ),
                        child: Text(
                          translation(context).txtStart,
                          style: Primaryfont.ligh(12)
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFFFDB9D),
            ),
            width: sWidth,
            height: sHeight,
            // color: Color(0xFFFFDB9D),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      imgHomeBgRelextion,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(aLeft, 0.0),
                  child: RichText(
                    text: TextSpan(
                      text: "${translation(context).txtRelexation}\n",
                      style: Primaryfont.bold(20)
                          .copyWith(color: Colors.black, height: 1.5),
                      children: [
                        TextSpan(
                          text: translation(context).txtMusic,
                          style: Primaryfont.bold(10)
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: pLeft, top: 20),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        '3-10 ${translation(context).txtMin}',
                        style: Primaryfont.medium(12)
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        width: sbWidth,
                      ),
                      MaterialButton(
                        onPressed: () async {
                         Get.to(() => CourseDetails(
                          titleDetail: translation(context).txtCourseDetailHeaderSubTitle1,
                          subTitleDetail: translation(context).txtCourseDetailHeaderSubTitle2,
                          titleOne: translation(context).txtCourseDetailTabbarTitle1, 
                          titleTwo: translation(context).txtCourseDetailTabbarTitle2, 
                          futureFavourite: controllerStatistical.getTotalFavouriteRelaxationMusic(),
                          futureListen: controllerStatistical.getTotalViewRelaxationMusic(),
                          futureOne: contronller.getMusicMeditationRelaxationPiano(),
                          futureTwo: contronller.getMusicMeditationRelaxationJazz(),
                          ),
                          );
                        },
                        minWidth: 54,
                        height: 40,
                        color: const Color(0xFF263238),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(38),
                        ),
                        child: Text(
                          translation(context).txtStart,
                          style: Primaryfont.ligh(12).copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
