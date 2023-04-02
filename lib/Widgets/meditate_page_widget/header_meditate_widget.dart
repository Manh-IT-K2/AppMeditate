import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';

class HeaderMeditateWidget extends StatelessWidget {
  const HeaderMeditateWidget({
    super.key,
    required this.sTextTitle,
    required this.sTextSubtitle,
  });

  final double sTextTitle, sTextSubtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              txtMeditateHeaderTitle,
              style: Primaryfont.bold(sTextTitle).copyWith(color: Colors.black),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: Text(
              txtMeditateHeaderSubTitle,
              style: Primaryfont.ligh(sTextSubtitle)
                  .copyWith(color: kColorDartPrimary, height: 1.3),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
