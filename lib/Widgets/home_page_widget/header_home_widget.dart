import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/signin_controller.dart';

class HeaderHomeWidget extends StatelessWidget {
  const HeaderHomeWidget({
    super.key,
    this.sImgWidth,
    required this.sTextSubTitle,
    required this.sTextTitle,
  });

  final double? sImgWidth, sTextTitle, sTextSubTitle;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 12),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset(
              imgLogoBlack,
              width: sImgWidth,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: controller.getStringUsername(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              String username = snapshot.data ?? "";
              return Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: "$txtHomeHeaderTitle $username\n",
                    style: Primaryfont.bold(sTextTitle!).copyWith(
                      color: Colors.black,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: txtHomeHeaderSubTitle,
                        style: Primaryfont.medium(sTextSubTitle!)
                            .copyWith(color: kColorDartPrimary),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
