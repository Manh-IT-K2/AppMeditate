import 'package:flutter/material.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/language_controller.dart';

class HeaderCourseDetailWidget extends StatelessWidget {
  const HeaderCourseDetailWidget({
    super.key,
    required this.title,
    required this.subTitle
  });

  final String title, subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            translation(context).txtCourseDetailHeaderTitle,
            textAlign: TextAlign.left,
            style: Primaryfont.bold(24).copyWith(
              color: Colors.black,
              //height: 1,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: Primaryfont.ligh(14).copyWith(
              color: Colors.black,
              height: 4,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            textAlign: TextAlign.left,
            subTitle,
            style: Primaryfont.ligh(14).copyWith(
              color: Colors.black,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}