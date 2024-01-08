import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/screen/my_list_screen.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Pages/unlock_premium_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:meditation_app/controller/music_controller.dart';
import 'package:meditation_app/controller/statistical_controller.dart';

class FunctionUserWidget extends StatelessWidget {
  const FunctionUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerStatistical = Get.put(StatisticalController());
    final controllerMusic = Get.put(MusicController());
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: kColorPrimary),
                      child: const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      translation(context).txtUserFunction1,
                      style: Primaryfont.bold(14).copyWith(color: Colors.black),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const UnclockPremium());
                  },
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.grey,
                    size: 25,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      translation(context).txtUserFunction2,
                      style: Primaryfont.bold(14).copyWith(color: Colors.black),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    SaveChange.checkMusicImage = true;
                    SaveChange.checkFavouriteDownload = true;
                    Get.to(
                        () => MyListScreen(
                          title: translation(context).txtUserFunction2, 
                          gif: imgUserMyFavourite,
                          icon: Icons.favorite, 
                          colorIcon: Colors.pink, 
                          future:  controllerStatistical.getListFavouriteByUser()));
                  },
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.grey,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.download,
                      color: Colors.black,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      translation(context).txtUserFunction3,
                      style: Primaryfont.bold(14).copyWith(color: Colors.black),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    SaveChange.checkMusicImage = false;
                    SaveChange.checkFavouriteDownload = false;
                    Get.to(() => MyListScreen(
                      title: translation(context).txtUserFunction3, 
                      gif: imgUserMyOffline,
                      icon: Icons.delete_outline, 
                      colorIcon: Colors.black, 
                      future: controllerMusic.loadMusicList()));
                  },
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.grey,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
