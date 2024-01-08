import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/data/data_controller.dart';
import 'package:meditation_app/Common/internet/check_internet.dart';
import 'package:meditation_app/Common/widget/header_circle_widget.dart';
import 'package:meditation_app/Common/widget/header_widget.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Pages/detail_music_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:meditation_app/controller/music_controller.dart';
import 'package:meditation_app/model/musics_model.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final internetController = Get.put(InternetController());
  @override
  void initState() {
    //checkInternet();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    super.initState();
  }

  // checkInternet() async {
  //   bool isConnected = await internetController.checkInternetConnectivity();
  //   if (mounted) {
  //     setState(() {
  //       isCheckInternet = isConnected;
  //     });
  //   }
  // }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final DataController dataController = Get.put(DataController());
    final contronller = Get.put(MusicController());

    return Scaffold(
      backgroundColor: kColorLightGrey,
      body: Stack(
        children: [
          HeaderWidget(
              sTextTitle: 24,
              sTextSubtitle: 14,
              colorTextTitle: Colors.black,
              colorTextSubTitle: kColorDartPrimary,
              txtHeaderTitle: translation(context).txtMusicHeaderTitle,
              txtHeaderSubTitle: translation(context).txtMusicHeaderSubTitle),
          const HeaderCircleWidget(
            color: Color(0xFF1ECBE9),
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 20,
            child: FutureBuilder<List<MusicsModel>?>(
              future: contronller.getAllMusic(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  // nếu không có dữ liệu thì hiện vòng xoay
                  return SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Align(
                      alignment: Alignment.center,
                      child: SpinKitFadingCircle(
                        color: Colors.pink,
                        size: 50.0,
                        controller: _animationController,
                      ),
                    ),
                  );
                }
                final musics = snapshot.data!;
                return MasonryGridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10, // cách đều bên phải trái
                  mainAxisSpacing: 16, // cách đều trên dưới
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  itemCount: musics.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      // nhấn vào sẽ chuyển sang trang reminderspage
                      onTap: () async {
                        SaveChange.checkMusicImage = false;
                        final isCheckInternet = await internetController
                            .checkInternetConnectivity();
                        if (isCheckInternet == true) {
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
                                  musics[index].id,
                              "musicTitle": dataController.musicTitle.value =
                                  musics[index].title,
                              "musicAuthor": dataController.musicAuthor.value =
                                  musics[index].author,
                              "musicImage": dataController.musicImage.value =
                                  musics[index].image,
                              "musicUrl": dataController.musicUrl.value =
                                  musics[index].url,
                            },
                          );
                        } else {
                          Get.snackbar(
                            "!",
                            "Network error",
                            colorText: Colors.red,
                          );
                        }
                      },
                      child: SizedBox(
                        height: 240,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: kColorLightYellow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              LayoutBuilder(
                                // đọc được contraints của thằng cha cho thằng con
                                builder: (context, constraints) {
                                  return ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: CachedNetworkImage(
                                      imageUrl: musics[index].image,
                                      width: constraints.maxWidth,
                                      fit: BoxFit.fill,
                                      errorWidget: (context, url, error) {
                                        return Image.asset(
                                          imgChatbotError,
                                          width: constraints.maxWidth,
                                          fit: BoxFit.fill,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  '${musics[index].title}\n',
                                  style: Primaryfont.bold(14).copyWith(
                                    color: Colors.black,
                                    height: 2,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  musics[index].author,
                                  style: Primaryfont.ligh(12).copyWith(
                                      color: Colors.black, height: 1.5),
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
    );
  }
}
