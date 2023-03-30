import 'package:flutter/material.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/signup_or_signin_page_widget/background_signupin_widget.dart';
import 'package:meditation_app/Widgets/signup_or_signin_page_widget/body_background_row_signupin_widget.dart';
import 'package:meditation_app/Widgets/signup_or_signin_page_widget/body_text_row_signupin_widget.dart';
import 'package:meditation_app/Widgets/signup_or_signin_page_widget/bodytext_signupin_widget.dart';
import 'package:meditation_app/Widgets/signup_or_signin_page_widget/footer_signupin_widget.dart';

class SingupOrSignin extends StatelessWidget {
  const SingupOrSignin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: context.orientation == Orientation.portrait
            ? Stack(
                children: [
                  BackgroundSignUpOrSignIn(size: size),
                  const BodyTextSignUpOrSignIn(),
                  FooterSignUpOrSignIn(
                    size: MaterialStateProperty.all(
                      Size(size.width * 0.9, size.height * 0.065),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  BodytextRowSignUpOrSignIn(size: size),
                  BodyBackgroundRowSignUpOrSignIn(
                    size: MaterialStateProperty.all(
                      Size(size.width * 0.3, size.height * 0.065),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
