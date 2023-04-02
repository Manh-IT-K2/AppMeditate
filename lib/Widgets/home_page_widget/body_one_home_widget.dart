import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Pages/course_details_page.dart';
import 'package:meditation_app/Utils/theme.dart';

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
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
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
                      text: 'Basics\n',
                      style: Primaryfont.bold(20).copyWith(
                        color: kColorLightYellow,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'COURSE',
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
                        '3-10 MIN',
                        style: Primaryfont.medium(12)
                            .copyWith(color: kColorLightGrey),
                      ),
                      SizedBox(
                        width: sbWidth,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                SaveChange.indexPage = 2;
                                return const CourseDetails();
                              },
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
                          'START',
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
                      text: 'Relexation\n',
                      style: Primaryfont.bold(20)
                          .copyWith(color: Colors.black, height: 1.5),
                      children: [
                        TextSpan(
                          text: 'MUSIC',
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
                        '3-10 MIN',
                        style: Primaryfont.medium(12)
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        width: sbWidth,
                      ),
                      MaterialButton(
                        onPressed: () {},
                        minWidth: 54,
                        height: 40,
                        color: const Color(0xFF263238),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(38),
                        ),
                        child: Text(
                          'START',
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
