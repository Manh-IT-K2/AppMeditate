import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:meditation_app/Common/data/data_controller.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Pages/detail_music_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:meditation_app/model/musics_model.dart';

// ignore: must_be_immutable
class RelaxJazzWidget extends StatelessWidget {
  RelaxJazzWidget({
    super.key,
    required this.future,
  });

  Future<List<MusicsModel>> future;
  @override
  Widget build(BuildContext context) {
    final dataController = Get.put(DataController());
    final size = context.screenSize;
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List<MusicsModel>>(
            future: future,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(
                  width: size.width,
                  height: 150,
                  child: Center(
                    child: GifView.asset(imgcircular, height: 80,),
                  ),
                );
              }
              List<dynamic> jazz = snapshot.data!;
              return Column(
                children: [
                  for (var jazzs in jazz)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.3),
                        ),
                      ),
                      margin:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 20),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: kColorPrimary,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Image.network(jazzs.image),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          SizedBox(
                            width: 200,
                            child: InkWell(
                              onTap: () {
                                 SaveChange.checkMusicImage = false;
                                Get.to(
                                    DetailMusic(
                                      bgColor: kColorLightGrey,
                                      imageBg: imgMusicsBackGround,
                                      color: Colors.black,
                                      imageRelay: imgMusicIconRelayBright,
                                      imageForward: imgMusicIconSkipBright,
                                    ),
                                    arguments: {
                                       "musicId": dataController.musicId.value =
                              jazzs.id,
                                      "musicTitle": dataController
                                          .musicTitle.value = jazzs.title,
                                      "musicAuthor": dataController
                                          .musicAuthor.value = jazzs.author,
                                      "musicImage": dataController
                                          .musicImage.value = jazzs.image,
                                      "musicUrl": dataController
                                          .musicUrl.value = jazzs.url,
                                    });
                              },
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      jazzs.title,
                                      style: Primaryfont.bold(14).copyWith(
                                          color: Colors.black, height: 1.5),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      translation(context).txtAboutTime,
                                      style: Primaryfont.ligh(12).copyWith(
                                          color: kColorDartPrimary,
                                          height: 1.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
