import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Pages/detail_music_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/model/musicmodel.dart';

class FavoriteTabbarWidget extends StatelessWidget {
  const FavoriteTabbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          for (int i = 1; i < listSong.length; i++)
            Container(
              margin:
                  const EdgeInsets.only(top: 10, right: 0, left: 0, bottom: 10),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: kColorPrimary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  InkWell(
                    onTap: () {
                      //Navigator.of(context).pushNamed("$DetailFavorite");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailMusic(
                            nameSong: listSong[i]['namesong'],
                            duration: listSong[i]["urlsong"],
                            image: 'assets/images/bg_favorite.jpeg',
                          ),
                        ),
                      );
                      // player.play();
                    },
                    onDoubleTap: () {
                      player.stop();
                    },
                    child: SizedBox(
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              listSong[i]["namesong"],
                              style: Primaryfont.bold(14)
                                  .copyWith(color: Colors.black, height: 1.5),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '5 MIN',
                              textAlign: TextAlign.left,
                              style: Primaryfont.ligh(14)
                                  .copyWith(color: Colors.black, height: 1.5),
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
      ),
    );
  }
}
