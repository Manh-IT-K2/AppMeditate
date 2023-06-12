import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/data/data_controller.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/detail_music_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/music_controller.dart';
import 'package:meditation_app/model/musics_model.dart';

class SleepDetailPage extends StatefulWidget {
  const SleepDetailPage({super.key});

  @override
  State<SleepDetailPage> createState() => _SleepDetailPageState();
}

class _SleepDetailPageState extends State<SleepDetailPage>
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
    String idSleep = atguments["idSleep"];
    String titleSleep = atguments["titleSleep"];
    final size = context.screenSize;
    return Scaffold(
      backgroundColor: const Color(0xFF1F265E),
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
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  alignment: Alignment.center,
                  child: Text(
                    titleSleep,
                    style: Primaryfont.bold(24).copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: FutureBuilder<List<MusicsModel>>(
                    future: controller.getMusicSleep(idSleep),
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
                              Get.to(() => DetailMusic(
                                bgColor: const Color.fromARGB(255, 52, 61, 131),
                                imageBg: imgMusicsBGSleep, 
                                color: Colors.white,
                                imageForward: imgMusicIconSkipDark,
                                imageRelay: imgMusicIconRelayDark,), arguments: {
                                  "musicId": dataController.musicId.value =
                              music.id,
                                "musicTitle": dataController.musicTitle.value =
                                    music.title,
                                "musicAuthor": dataController
                                    .musicAuthor.value = music.author,
                                "musicImage": dataController.musicImage.value =
                                    music.image,
                                "musicUrl": dataController.musicUrl.value =
                                    music.url,
                              });
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: const Color(0xFF1F265E),
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
