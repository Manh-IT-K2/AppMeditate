import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meditation_app/Page/detail_favorite.dart';
import 'package:meditation_app/model/musicmodel.dart';
import '../Utils/theme.dart';

class FemaleVoice extends StatelessWidget {
  const FemaleVoice({super.key});

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          for (int i = 1; i < list_music_friend.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
              ),
              margin: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: kColorPrimary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Image.asset(
                      list_music_friend[i]['image'],
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailFavorite(
                            nameSong: list_music_friend[i]['nameSong'],
                            duration: list_music_friend[i]['urlSong'],
                            image: list_music_friend[i]['image'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 200,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              list_music_friend[i]["nameSong"],
                              style: Primaryfont.bold(14)
                                  .copyWith(color: Colors.black, height: 1.5),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '5 MIN',
                              style: Primaryfont.ligh(12).copyWith(
                                  color: kColorDartPrimary, height: 1.5),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
