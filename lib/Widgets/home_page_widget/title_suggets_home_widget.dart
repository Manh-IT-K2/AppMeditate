import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/data/data_controller.dart';
import 'package:meditation_app/Common/screen/detail_meditation_screen.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:meditation_app/controller/music_controller.dart';

class TitleSuggestHomeWidget extends StatelessWidget {
  const TitleSuggestHomeWidget({
    super.key,
    required this.sHeight,
    required this.sWidth,
  });

  final double sHeight, sWidth;
  @override
  Widget build(BuildContext context) {
    final dataController = Get.put(DataController());
    final controllerMusic = Get.put(MusicController());
    return Container(
      height: sHeight,
      width: sWidth,
      margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF333242),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imgHomeBgDailythounght,
              fit: BoxFit.fill,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: const Alignment(0.2, 0.0),
                  child: RichText(
                    text: TextSpan(
                      text: '${translation(context).txtDailyThought}\n',
                      style: Primaryfont.bold(20)
                          .copyWith(color: Colors.white, height: 2),
                      children: [
                        TextSpan(
                          text: translation(context).txtMeditation,
                          style: Primaryfont.ligh(12)
                              .copyWith(color: Colors.white),
                          children: [
                            TextSpan(
                              text: ' • 3-10 ${translation(context).txtMin}',
                              style: Primaryfont.ligh(12)
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: const Alignment(0.7, 0.0),
                  child: IconButton(
                    onPressed: () {
                      Get.to(
                          () => MeditationDetailPage(
                                icon: Icons.sunny,
                                colorText: Colors.black,
                                colorItem: kColorLightGrey,
                                backgroundColor: Colors.white,
                                future: controllerMusic
                                    .getMusicMeditateDailyThought(),
                              ),
                          arguments: {
                            "titleMeditation": dataController
                                .titleMeditation.value = translation(context).txtDailyThought
                          });
                    },
                    icon: Image.asset(imgHomeIcPlay),
                    iconSize: 40,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
