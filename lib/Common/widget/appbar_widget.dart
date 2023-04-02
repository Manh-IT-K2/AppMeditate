import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    super.key,
    required this.sBoder,
    required this.sIcon,
    required this.sText,
    required this.colorText,
    required this.sWidthImage,
    required this.sHeightImage,
    required this.sWidthContainer,
    required this.sHeightContainer,
  });
  final double sWidthContainer,
      sHeightContainer,
      sBoder,
      sIcon,
      sText,
      sWidthImage,
      sHeightImage;
  final Color  colorText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                width: sWidthContainer,
                height: sHeightContainer,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sBoder),
                  color: kColorPrimary,
                ),
                child: Icon(
                  Icons.apps_sharp,
                  size: sIcon,
                  color: Colors.white,
                ),
              ),
              Text(
                txtAll,
                style: Primaryfont.ligh(sText)
                    .copyWith(color: colorText, height: 1.8),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Container(
                width: sWidthContainer,
                height: sHeightContainer,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sBoder),
                  color: kColorDartPrimary,
                ),
                child: Icon(
                  Icons.favorite_border,
                  size: sIcon,
                  color: Colors.white,
                ),
              ),
              Text(
                txtMy,
                style: Primaryfont.ligh(sText)
                    .copyWith(color: kColorDartPrimary, height: 1.8),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Container(
                width: sWidthContainer,
                height: sHeightContainer,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sBoder),
                  color: kColorDartPrimary,
                ),
                child: Icon(
                  Icons.emoji_emotions_outlined,
                  size: sIcon,
                  color: Colors.white,
                ),
              ),
              Text(
                txtAnxious,
                style: Primaryfont.ligh(sText)
                    .copyWith(color: kColorDartPrimary, height: 1.8),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Container(
                width: sWidthContainer,
                height: sHeightContainer,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sBoder),
                  color: kColorDartPrimary,
                ),
                child: Image.asset(
                  imgIcMoon,
                  width: sWidthImage,
                  height: sHeightImage,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                txtSleep,
                style: Primaryfont.ligh(sText)
                    .copyWith(color: kColorDartPrimary, height: 1.8),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Container(
                width: sWidthContainer,
                height: sHeightContainer,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sBoder),
                  color: kColorDartPrimary,
                ),
                child: Image.asset(
                  
                  imgIcKids,
                  width: sWidthImage,
                  height: sHeightImage,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                txtKids,
                style: Primaryfont.ligh(sText)
                    .copyWith(color: kColorDartPrimary, height: 1.8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
