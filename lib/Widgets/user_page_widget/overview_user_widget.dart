import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/language_controller.dart';

class OverviewUserWidget extends StatelessWidget {
  const OverviewUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translation(context).txtUserOverview,
                  style: Primaryfont.bold(14).copyWith(color: Colors.black),
                ),
                Row(
                  children: [
                    Text(
                      translation(context).txtTotal,
                      style: Primaryfont.ligh(14)
                          .copyWith(color: kColorDartPrimary),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 20,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Image.asset(
                        imgUserTelevision,
                        color: Colors.black,
                        height: 25,
                      ),
                      Text(
                        translation(context).txtLesson,
                        style: Primaryfont.thin(14)
                            .copyWith(color: Colors.black, height: 2),
                      ),
                      Text(
                        translation(context).txtCount,
                        style: Primaryfont.thin(14)
                            .copyWith(color: Colors.black, height: 1.2),
                      ),
                      Text(
                        '15',
                        style: Primaryfont.bold(24)
                            .copyWith(color: kColorPrimary, height: 2),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Image.asset(
                        imgUserAlarmclock,
                        color: Colors.black,
                        height: 25,
                      ),
                      Text(
                        translation(context).txtMeditation1,
                        style: Primaryfont.thin(14)
                            .copyWith(color: Colors.black, height: 2),
                      ),
                      Text(
                        translation(context).txtMinute,
                        style: Primaryfont.thin(14)
                            .copyWith(color: Colors.black, height: 1.2),
                      ),
                      Text(
                        '423',
                        style: Primaryfont.bold(24)
                            .copyWith(color: kColorPrimary, height: 2),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Image.asset(
                        imgUserTodolist,
                        color: Colors.black,
                        height: 25,
                      ),
                      Text(
                        translation(context).txtCurrent,
                        style: Primaryfont.thin(14)
                            .copyWith(color: Colors.black, height: 2),
                      ),
                      Text(
                        translation(context).txtStreak,
                        style: Primaryfont.thin(14)
                            .copyWith(color: Colors.black, height: 1.2),
                      ),
                      Text(
                        '12',
                        style: Primaryfont.bold(24)
                            .copyWith(color: kColorPrimary, height: 2),
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
