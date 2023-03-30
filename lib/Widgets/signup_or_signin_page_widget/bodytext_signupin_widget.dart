import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';

class BodyTextSignUpOrSignIn extends StatelessWidget {
  const BodyTextSignUpOrSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const Alignment(0.0, 0.25),
          child: Text(
            txtSignUpInTitle,
            textAlign: TextAlign.center,
            style: Primaryfont.bold(24).copyWith(
              color: Colors.black,
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0.0, 0.40),
          child: Text(
           txtSignUpInSubTitle,
            textAlign: TextAlign.center,
            style: Primaryfont.ligh(14)
                .copyWith(color: kColorDartGrey, height: 1.5),
          ),
        ),
      ],
    );
  }
}