import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';

class HeaderCourseDetailWidget extends StatelessWidget {
  const HeaderCourseDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            txtCourseDetailHeaderTitle,
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
            txtCourseDetailHeaderSubTitle1,
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
            txtCourseDetailHeaderSubTitle2,
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