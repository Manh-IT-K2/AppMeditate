import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditation_app/Constant/image_string.dart';

class BackgroundSignUpOrSignIn extends StatelessWidget {
  const BackgroundSignUpOrSignIn({
    super.key,
    required this.size,
  });

  final Size size;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FractionallySizedBox(
          heightFactor: 0.5,
          widthFactor: 1,
          child: FittedBox(
            fit: BoxFit.cover,
            child: SvgPicture.asset(
              imgBackgroundSignUpIn2,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SvgPicture.asset(
            imgLogoSignUpIn,
            width: size.width * 0.5,
            alignment: Alignment.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 100, right: 20),
          child: FractionallySizedBox(
            heightFactor: 0.3,
            widthFactor: 1,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  imgBackgroundSignUpIn1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
