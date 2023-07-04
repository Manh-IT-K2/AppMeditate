import 'dart:io';
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
import 'package:meditation_app/controller/music_controller.dart';
import 'package:meditation_app/controller/statistical_controller.dart';
import 'package:meditation_app/model/musics_model.dart';

// ignore: must_be_immutable
class MyListScreen extends StatefulWidget {
  MyListScreen({
    super.key,
    required this.title,
    required this.gif,
    required this.icon,
    required this.colorIcon,
    required this.future,
  });
  final String title, gif;
  final IconData icon;
  final Color colorIcon;
  Future<List<MusicsModel>> future;

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final controller = Get.put(MusicController());
    final controllerStatistical = Get.put(StatisticalController());
    final dataController = Get.put(DataController());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 121, 179, 227),
      body: Column(
        children: [
          Container(
            height: size.height *0.3,
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(200),
                bottomRight: Radius.circular(200),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                        Text(
                         translation(context).txtBack,
                          style: Primaryfont.medium(14)
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GifView.asset(
                      widget.gif,
                      height: size.height * 0.140,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.title,
                      style: Primaryfont.bold(20).copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: size.height * 0.7,
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: FutureBuilder<List<MusicsModel>>(
                future: widget.future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: 500,
                      child: GifView.asset(
                        imgcircular,
                        width: 50,
                        height: 50,
                        ),
                    );
                  }
                  List<dynamic> listMusic = snapshot.data!;
                  return SingleChildScrollView(
                    child: SizedBox(
                      height: size.height *0.65,
                      width: size.width,
                      child: ListView.builder(
                        itemCount: listMusic.length,
                        itemBuilder: (context, index) {
                          MusicsModel music = listMusic[index];
                          File imageFile = File(music.image);
                          return Container(
                            margin:
                                const EdgeInsets.only(left: 20, right: 20, top: 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                            ),
                            width: size.width,
                            height: 60,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                  ),
                                  child: SaveChange.checkMusicImage
                                      ? Image.network(
                                          music.image,
                                          width: 60,
                                          height: 60,
                                        )
                                      : Image.file(
                                          imageFile,
                                          width: 60,
                                          height: 60,
                                        ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (SaveChange.checkFavouriteDownload == true) {
                                      SaveChange.checkMusicImage = false;
                                    } else {
                                      SaveChange.checkMusicImage = true;
                                    }
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
                                              music.id,
                                          "musicTitle": dataController
                                              .musicTitle.value = music.title,
                                          "musicAuthor": dataController
                                              .musicAuthor.value = music.author,
                                          "musicImage": dataController
                                              .musicImage.value = music.image,
                                          "musicUrl": dataController
                                              .musicUrl.value = music.url,
                                        });
                                  },
                                  child: SizedBox(
                                    width: 190,
                                    child: Text(
                                      music.title,
                                      style: Primaryfont.medium(14)
                                          .copyWith(color: Colors.black),
                                      overflow: TextOverflow
                                          .ellipsis, // Hiển thị ba dấu chấm khi xuống hàng
                                      maxLines:
                                          1, // Giới hạn hiển thị chỉ trên một dòng
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    final statistical = await controllerStatistical
                                        .getDetailStatistical(music.id);
                                    final totalDownload = statistical.download! - 1;
                                    final totalFourite = statistical.favourite! - 1;
                                    if (SaveChange.checkMusicImage == true) {
                                      setState(() {
                                        controllerStatistical.deleteIdUserFavourite(statistical.id!);
                                        listMusic.remove(music);
                                      });
                                      await controllerStatistical.updateFavouriteStatistical(statistical.id!, totalFourite);
                                    } else {
                                      setState(() {
                                        controllerStatistical.deleteIdUserDownload(statistical.id!);
                                        controller.removeMusicFromList(music.id);
                                        listMusic.remove(music);
                                      });
                                      await controllerStatistical.updateDownloadStatistical(statistical.id!, totalDownload);
                                    }
                                  },
                                  icon: Icon(
                                    widget.icon,
                                    size: 30,
                                    color: widget.colorIcon,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
