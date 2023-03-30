import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';

class BodytextRowSignUpOrSignIn extends StatelessWidget {
  const BodytextRowSignUpOrSignIn({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Align(
              alignment: const Alignment(0.0, -0.6),
              child: SvgPicture.asset(
                imgLogoSignUpIn,
                width: size.width * 0.3,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                txtSignUpInTitle,
                textAlign: TextAlign.center,
                style: Primaryfont.bold(34).copyWith(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Text(
           txtSignUpInSubTitle,
            textAlign: TextAlign.center,
            style: Primaryfont.ligh(20)
                .copyWith(color: kColorDartGrey, height: 1.5),
          ),
        ],
      ),
    );
  }
}
