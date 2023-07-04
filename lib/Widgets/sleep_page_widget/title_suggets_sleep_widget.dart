import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/language_controller.dart';

class TitleSuggetWidget extends StatelessWidget {
  const TitleSuggetWidget({
    super.key,
    required this.sIcon,
    required this.sTextTitle,
    required this.sTextSubTitle,
    required this.sWidthImage,
    required this.sHeightIcon,
    required this.sWidthIcon,
    required this.sHeightButton,
    required this.sWidthButton,
    required this.sBoderIcon,
  });

  final double sWidthImage, sIcon, sTextTitle, sTextSubTitle, sHeightButton, sWidthButton, sHeightIcon, sWidthIcon, sBoderIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imgSleepBgTheOceanMoon,
              width: sWidthImage,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: sHeightIcon,
                  width: sWidthIcon,
                  margin: const EdgeInsets.only(left: 20, top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(sBoderIcon),
                    color: const Color.fromARGB(255, 242, 242, 244),
                  ),
                  child: Icon(
                    Icons.lock_open_outlined,
                    color: Colors.black,
                    size: sIcon,
                  ),
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: translation(context).txtSleepSuggetTitle,
                  style:
                      Primaryfont.bold(sTextTitle).copyWith(color: kColorLightYellow),
                  children: [
                    TextSpan(
                      text: translation(context).txtSleepSuggetSubTitle,
                      style: Primaryfont.ligh(sTextSubTitle)
                          .copyWith(color: Colors.white, height: 2),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: MaterialButton(
                  onPressed: () {
                    // Navigator.of(context).pushNamed();
                  },
                  color: Colors.white,
                  height: sHeightButton,
                  minWidth: sWidthButton,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(38),
                  ),
                  child: Text(
                    translation(context).txtStart,
                    style: Primaryfont.ligh(sTextSubTitle).copyWith(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
