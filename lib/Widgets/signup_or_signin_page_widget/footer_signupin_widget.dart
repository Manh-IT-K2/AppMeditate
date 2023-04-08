import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Pages/sign_in_page.dart';
import 'package:meditation_app/Pages/sign_up_page.dart';
import 'package:meditation_app/Utils/theme.dart';

class FooterSignUpOrSignIn extends StatelessWidget {
  const FooterSignUpOrSignIn({
    super.key,
    required this.size,
  });

  final MaterialStateProperty<Size> size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(1),
          child: Align(
            alignment: const Alignment(0.0, 0.75),
            child: ElevatedButton(
              onPressed: () {
                //Navigator.of(context).pushNamed('$SignUp');
                Get.to(() => const SignUp());
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
               txtSignUp,
                style: Primaryfont.ligh(14).copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0.0, 0.90),
          child: FittedBox(
            child: Row(
              children: [
                Text(
                 txtAlreadyAccount,
                  style:
                      Primaryfont.medium(12).copyWith(color: kColorDartPrimary),
                ),
                TextButton(
                  onPressed: () {
                    Get.off(() => const SignIn());
                  },
                  child: Text(
                    txtSignIn,
                    style: Primaryfont.medium(12).copyWith(
                      color: kColorPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
