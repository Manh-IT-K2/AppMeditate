import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/signin_controller.dart';

class GetStatedHeader extends StatelessWidget {
  const GetStatedHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    return Column(
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Image.asset(
            tLogoGetstartedImage,
            width: 200,
            alignment: const Alignment(0.0, -0.8),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: FittedBox(
            child: FutureBuilder(
              future: controller.getStringUsername(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                String username = snapshot.data ?? "";
                return RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Hi $username ! Wecome\n",
                      style: Primaryfont.medium(30).copyWith(
                        color: kColorLightYellow,
                        height: 1.3,
                      ),
                      children: [
                        TextSpan(
                          text: tGetstartedTitle2,
                          style: Primaryfont.thin(30).copyWith(
                            color: kColorLightYellow,
                          ),
                        )
                      ]),
                );
              },
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: SizedBox.expand(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FittedBox(
                  child: Text(
                    tGetstartedSubTitle,
                    style: Primaryfont.ligh(16).copyWith(
                      color: kColorLightGrey,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
