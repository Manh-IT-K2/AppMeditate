import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/data/data_controller.dart';
import 'package:meditation_app/Common/internet/check_internet.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Pages/detail_music_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:meditation_app/model/musics_model.dart';

// ignore: must_be_immutable
class MeditationDetailPage extends StatefulWidget {
  MeditationDetailPage({
    super.key,
    required this.future,
    required this.icon,
    required this.colorText,
    required this.colorItem,
    required this.backgroundColor,
  });

  Future<List<MusicsModel>> future;
  Color backgroundColor, colorText, colorItem;
  IconData icon;
  @override
  State<MeditationDetailPage> createState() => _MeditationDetailPageState();
}

class _MeditationDetailPageState extends State<MeditationDetailPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(MusicController());
    final dataController = Get.put(DataController());
    final internetController = Get.put(InternetController());
    final atguments = Get.arguments;
    //String idMeditation = atguments["idMeditation"];
    String titleMeditation = atguments["titleMeditation"];
    final size = context.screenSize;
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: widget.colorText,
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    top: 60,
                    left: 0,
                    child: Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        color: widget.colorItem,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(100),
                          topRight: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 100),
                        child: Icon(
                          Icons.star_border_outlined,
                          color: widget.colorText,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    right: 0,
                    child: Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        color: widget.colorItem,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(100),
                          topRight: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: Icon(
                          Icons.star_border_outlined,
                          color: widget.colorText,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: size.width * 0.13,
                    child: Container(
                      height: 130,
                      width: 250,
                      decoration: BoxDecoration(
                        color: widget.colorItem,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(100),
                            topRight: Radius.circular(100),
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 60),
                        child: Icon(
                          widget.icon,
                          color: widget.colorText,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: size.width * 0.25,
                    child: Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      alignment: Alignment.center,
                      child: Text(
                        titleMeditation,
                        style: Primaryfont.bold(24)
                            .copyWith(color: widget.colorText),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.only(top: 180),
                      width: size.width,
                      height: size.height * 0.85,
                      child: FutureBuilder<List<MusicsModel>>(
                        future: widget.future,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return SizedBox(
                              width: size.width,
                              height: size.height,
                              child: Align(
                                alignment: Alignment.center,
                                child: SpinKitFadingCircle(
                                  color: Colors.pink,
                                  controller: _animationController,
                                ),
                              ),
                            );
                          }
                          final listMusic = snapshot.data!;
                          return MasonryGridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 16,
                            itemCount: listMusic.length,
                            itemBuilder: (context, index) {
                              final music = listMusic[index];
                              return InkWell(
                                onTap: () async {
                                  SaveChange.checkMusicImage = false;
                                  final isCheckInternet =
                                      await internetController
                                          .checkInternetConnectivity();
                                  if (isCheckInternet == true) {
                                    Get.to(
                                        () => DetailMusic(
                                              bgColor: kColorLightGrey,
                                              imageBg: imgMusicsBackGround,
                                              color: Colors.black,
                                              imageRelay:
                                                  imgMusicIconRelayBright,
                                              imageForward:
                                                  imgMusicIconSkipBright,
                                            ),
                                        arguments: {
                                          "musicId": dataController
                                              .musicId.value = music.id,
                                          "musicTitle": dataController
                                              .musicTitle.value = music.title,
                                          "musicAuthor": dataController
                                              .musicAuthor.value = music.author,
                                          "musicImage": dataController
                                              .musicImage.value = music.image,
                                          "musicUrl": dataController
                                              .musicUrl.value = music.url,
                                        });
                                  } else {
                                    Get.snackbar(
                                      "!",
                                      "Network error",
                                      colorText: Colors.red,
                                    );
                                  }
                                },
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: widget.colorItem,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SizedBox(
                                    height: 250,
                                    child: Column(
                                      children: [
                                        LayoutBuilder(
                                          builder: ((context, constraints) {
                                            return ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10),
                                                      topLeft:
                                                          Radius.circular(10)),
                                              child: Image.network(
                                                music.image,
                                                width: constraints.maxWidth,
                                              ),
                                            );
                                          }),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Text(
                                            '${music.title}\n',
                                            style:
                                                Primaryfont.bold(14).copyWith(
                                              color: widget.colorText,
                                              height: 2,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Text(
                                          "1 - 3 ${translation(context).txtMinute}",
                                          style: Primaryfont.ligh(12).copyWith(
                                              color: widget.colorText,
                                              height: 1.5),
                                        ),
                                        // Container(
                                        //   padding: const EdgeInsets.only(
                                        //       top: 15, left: 5),
                                        //   alignment: Alignment.centerLeft,
                                        //   child: RichText(
                                        //     text: TextSpan(
                                        //       text: '${music.title}\n',
                                        //       style: Primaryfont.bold(14)
                                        //           .copyWith(
                                        //               color: widget.colorText,
                                        //               height: 1.5),
                                        //       children: [
                                        //         TextSpan(
                                        //           text:
                                        //               "1 - 3 ${translation(context).txtMinute}",
                                        //           style: Primaryfont.ligh(12)
                                        //               .copyWith(
                                        //                   color:
                                        //                       widget.colorText,
                                        //                   height: 1.5),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
