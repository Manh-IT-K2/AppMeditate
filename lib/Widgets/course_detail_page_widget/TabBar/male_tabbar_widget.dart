import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Pages/detail_music_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/model/musicmodel.dart';

class MaleTabbarWidget extends StatelessWidget {
  const MaleTabbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          for (int i = 1; i < listPiano.length; i++)
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
                    child: Image.asset(listPiano[i]['image']),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  SizedBox(
                    width: 200,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailMusic(
                                nameSong: listPiano[i]['namePiano'],
                                duration: listPiano[i]['urlPiano'],
                                image: listPiano[i]['image']),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              listPiano[i]["namePiano"],
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
