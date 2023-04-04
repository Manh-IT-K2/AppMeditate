import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';

class RecordCourseDetailWidget extends StatelessWidget {
  const RecordCourseDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.black, width: 0.2),
      )),
      child: Row(
        children: [
          const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Text(
                  '24.234',
                  style: Primaryfont.ligh(14).copyWith(
                    color: kColorDartPrimary,
                    height: 2,
                  ),
                ),
                Text(
                  txtCourseDetailHeaderTitleFavorite,
                  style: Primaryfont.ligh(14)
                      .copyWith(color: kColorDartPrimary, height: 1),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 100),
            child: Icon(
              Icons.headphones,
              color: Colors.blue,
              size: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Text(
                  '34.234',
                  style: Primaryfont.ligh(14).copyWith(
                    color: kColorDartPrimary,
                    height: 2,
                  ),
                ),
                Text(
                  txtCourseDetailHeaderTitleListening,
                  style: Primaryfont.ligh(14)
                      .copyWith(color: kColorDartPrimary, height: 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
