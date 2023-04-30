import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditation_app/Common/form/form_header_widget.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/signin_page_widget/form_body_signin_widget.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});
  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final ValueNotifier<bool> a = ValueNotifier<bool>(false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: context.orientation == Orientation.portrait
            ? Stack(
                children: [
                  // img background
                  SvgPicture.asset(
                    imgBackgroundSignUpIn3,
                    width: size.width,
                  ),
                  // button back
                  Column(
                    children: [
                      Column(
                        children: [
                          form_header_widget(
                              size: Size(size.width * 0.9, size.height * 0.065),
                              sHeight: size.height * 0.4,
                              sWidth: size.width * 1),
                        ],
                      ),
                      form_body_signin_widget(
                        a: a,
                        size: MaterialStateProperty.all(
                          Size(size.width * 0.9, size.height * 0.065),
                        ),
                        sHeight: size.height * 0.5,
                        sWidth: size.width * 1,
                        sHeightTF: size.height * 0.070,
                        sWidthTF: size.width * 0.9,
                        sFooter: 50,
                      ),
                    ],
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: form_header_widget(
                      size: Size(size.width * 0.35, size.height * 0.15),
                      sHeight: size.height * 1,
                      sWidth: size.width * 1,
                    ),
                  ),
                  Expanded(
                    child: form_body_signin_widget(
                      a: a,
                      size: MaterialStateProperty.all(
                        Size(size.width * 0.4, size.height * 0.065),
                      ),
                      sHeight: size.height * 1,
                      sWidth: size.width * 1,
                      sHeightTF: size.height * 0.15,
                      sWidthTF: size.width * 0.4,
                      sFooter: 30,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
