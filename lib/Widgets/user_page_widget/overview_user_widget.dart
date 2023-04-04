import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';

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
                  txtUserOverview,
                  style: Primaryfont.bold(14).copyWith(color: Colors.black),
                ),
                Row(
                  children: [
                    Text(
                      'Total',
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
                        'Lesson',
                        style: Primaryfont.thin(14)
                            .copyWith(color: Colors.black, height: 2),
                      ),
                      Text(
                        'count',
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
                        'Meditation',
                        style: Primaryfont.thin(14)
                            .copyWith(color: Colors.black, height: 2),
                      ),
                      Text(
                        'Minute',
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
                        'Current',
                        style: Primaryfont.thin(14)
                            .copyWith(color: Colors.black, height: 2),
                      ),
                      Text(
                        'Streak',
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
