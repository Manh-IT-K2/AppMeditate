import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/sign_in_page.dart';
import 'package:meditation_app/Pages/sign_up_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/language_controller.dart';

class BodyBackgroundRowSignUpOrSignIn extends StatelessWidget {
  const BodyBackgroundRowSignUpOrSignIn({
    super.key,
    required this.size,
  });

  final MaterialStateProperty<Size> size;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: FractionallySizedBox(
              heightFactor: 0.9,
              widthFactor: 1,
              child: SvgPicture.asset(
                imgBackgroundSignUpIn1,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Align(
              alignment: const Alignment(0.0, 0.75),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('$SignUp');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kColorPrimary),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(38),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(0),
                  fixedSize: size,
                ),
                child: Text(
                  translation(context).txtSignUp,
                  style: Primaryfont.ligh(14).copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Align(
              alignment: const Alignment(0.0, 0.90),
              child: FittedBox(
                child: Row(
                  children: [
                    Text(
                      translation(context).txtAlreadyAccount,
                      style: Primaryfont.medium(12)
                          .copyWith(color: kColorDartPrimary),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('$SignIn');
                      },
                      child: Text(
                        translation(context).txtSignIn,
                        style: Primaryfont.medium(12).copyWith(
                          color: kColorPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
