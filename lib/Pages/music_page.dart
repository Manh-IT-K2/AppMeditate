import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/data/data_controller.dart';
import 'package:meditation_app/Common/widget/header_circle_widget.dart';
import 'package:meditation_app/Common/widget/header_widget.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Pages/detail_music_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/music_controller.dart';
import 'package:meditation_app/model/musics_model.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    //final size = context.screenSize;
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
              txtHeaderTitle: txtMusicHeaderTitle,
              txtHeaderSubTitle: txtMusicHeaderSubTitle),
          const HeaderCircleWidget(),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 20,
            child: FutureBuilder<List<MusicsModel>>(
              future: contronller.getAllMusic(),
              builder: (context, snapshot) {
                // if(snapshot.hasError){
                //   print(snapshot.error.toString());
                // }
                // print(snapshot.data);
                if (!snapshot.hasData) {
                  // nếu không có dữ liệu thì hiện vòng xoay
                  return const Center(
                    child: CircularProgressIndicator(),
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
                      onTap: () {
                        Get.off(const DetailMusic(), arguments: {
                          "musicTitle": dataController.musicTitle.value = musics[index].title,
                          "musicAuthor": dataController.musicAuthor.value = musics[index].author,
                          "musicImage": dataController.musicImage.value = musics[index].image,
                          "musicUrl": dataController.musicUrl.value = musics[index].url,
                        });
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
                                    child: Image.asset(
                                      musics[index].image,
                                      width: constraints.maxWidth,
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: RichText(
                                  text: TextSpan(
                                    text: '${musics[index].title}\n',
                                    style: Primaryfont.bold(14)
                                        .copyWith(color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: musics[index].author,
                                        style: Primaryfont.ligh(12).copyWith(
                                            color: Colors.black, height: 1.5),
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
          )
        ],
      ),
    );
  }
}
