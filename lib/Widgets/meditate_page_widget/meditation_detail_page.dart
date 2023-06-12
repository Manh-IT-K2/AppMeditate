import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/data/data_controller.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/detail_music_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/music_controller.dart';
import 'package:meditation_app/model/musics_model.dart';

class MeditationDetailPage extends StatefulWidget {
  const MeditationDetailPage({super.key});

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
    final controller = Get.put(MusicController());
    final dataController = Get.put(DataController());
    final atguments = Get.arguments;
    String idMeditation = atguments["idMeditation"];
    String titleMeditation = atguments["titleMeditation"];
    final size = context.screenSize;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  alignment: Alignment.center,
                  child: Text(
                    titleMeditation,
                    style: Primaryfont.bold(24).copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: FutureBuilder<List<MusicsModel>>(
                    future: controller.getMusicMeditate(idMeditation),
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
                            onTap: () {
                              Get.to(
                                  () => DetailMusic(
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
                                    "musicUrl": dataController.musicUrl.value =
                                        music.url,
                                  });
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: kColorLightGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SizedBox(
                                height: 250,
                                child: Column(
                                  children: [
                                    LayoutBuilder(
                                      builder: ((context, constraints) {
                                        return ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              topLeft: Radius.circular(10)),
                                          child: Image.network(
                                            music.image,
                                            width: constraints.maxWidth,
                                          ),
                                        );
                                      }),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 5),
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          text: '${music.title}\n',
                                          style: Primaryfont.bold(14).copyWith(
                                              color: Colors.black, height: 1.5),
                                          children: [
                                            TextSpan(
                                              text: "1 - 3 Minute",
                                              style: Primaryfont.ligh(12)
                                                  .copyWith(
                                                      color: Colors.black,
                                                      height: 1.5),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
