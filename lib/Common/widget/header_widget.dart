import 'package:flutter/material.dart';
import 'package:meditation_app/Utils/theme.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.sTextTitle,
    required this.sTextSubtitle,
    required this.colorTextTitle,
    required this.colorTextSubTitle,
    required this.txtHeaderTitle,
    required this.txtHeaderSubTitle,
  });

  final double sTextTitle, sTextSubtitle;
  final Color colorTextTitle, colorTextSubTitle;
  final String txtHeaderTitle, txtHeaderSubTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              txtHeaderTitle,
              style: Primaryfont.bold(sTextTitle).copyWith(color: colorTextTitle),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: Text(
              txtHeaderSubTitle,
              style: Primaryfont.ligh(sTextSubtitle)
                  .copyWith(color: colorTextSubTitle, height: 1.3),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
