import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meditation_app/Page/ContainerPage.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/favourite_music.dart';
import 'package:meditation_app/Widgets/male_voice.dart';

import '../Widgets/female_voice.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: kColorLightGrey,
        //bottomNavigationBar: AppBar(),
        body: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/bg_coursedetails.png'),
                Container(
                  margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              alignment: Alignment.center,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('$ContainerPage');
                              },
                              icon: const Icon(Icons.arrow_back),
                              color: Colors.black,
                              iconSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: const Color.fromRGBO(34, 34, 34, 0.475),
                            child: IconButton(
                              alignment: Alignment.center,
                              onPressed: () {
                                final player = AudioPlayer();
                                final duration = player.setAsset(
                                    'assets/musics/thay mọi co gai yeu anh.mp3');
                                player.play();
                                //Navigator.of(context).pushNamed('$ContainerPage');
                              },
                              icon: Image.asset('assets/images/ic_heart.png'),
                              iconSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: const Color.fromRGBO(25, 25, 26, 0.475),
                            child: IconButton(
                              alignment: Alignment.center,
                              onPressed: () {
                                //Navigator.of(context).pushNamed('$ContainerPage');
                              },
                              icon: Image.asset('assets/images/ic_dowload.png'),
                              color: Colors.white,
                              iconSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                //alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Happy Morning',
                        textAlign: TextAlign.left,
                        style: Primaryfont.bold(24).copyWith(
                          color: Colors.black,
                          //height: 1,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'COURSE',
                        textAlign: TextAlign.left,
                        style: Primaryfont.ligh(14).copyWith(
                          color: Colors.black,
                          height: 4,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        textAlign: TextAlign.left,
                        'Ease the mind into a restful night’s sleep with\nthese deep, amblent tones.',
                        style: Primaryfont.ligh(14).copyWith(
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                    ),
                    Container(
                     padding: const EdgeInsets.only(bottom: 15),
                      decoration: const BoxDecoration(
                        border: Border(
                         bottom: BorderSide(color: Colors.black, width: 0.2),
                        )
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Text(
                                  '24.234',
                                  style: Primaryfont.ligh(14).copyWith(
                                    color: kColorDartPrimary,
                                    height: 2,
                                  ),
                                ),
                                Text(
                                  'favorits',
                                  style: Primaryfont.ligh(14).copyWith(
                                      color: kColorDartPrimary, height: 1),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 100),
                            child: Icon(
                              Icons.headphones,
                              color: Colors.blue,
                              size: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Text(
                                  '34.234',
                                  style: Primaryfont.ligh(14).copyWith(
                                    color: kColorDartPrimary,
                                    height: 2,
                                  ),
                                ),
                                Text(
                                  'listening',
                                  style: Primaryfont.ligh(14).copyWith(
                                      color: kColorDartPrimary, height: 1),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Choose a Theme',
                        style:
                            Primaryfont.ligh(24).copyWith(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 20),
                      child: TabBar(
                          unselectedLabelColor: kColorDartPrimary,
                          isScrollable: true,
                          labelColor: const Color(0xFF8E97FD),
                          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                          tabs: [
                            SizedBox(
                              width: size.width * 0.24,
                              child: const Tab(                             
                                child: Text(
                                  'RELAXPIANO',
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                  ),
                                  //style: Primaryfont.medium(24).copyWith(color: Color(0xFF8E97FD)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.23,
                              child: const Tab(
                                child: Text(
                                  'NHIII',
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.23,
                              child: const Tab(
                                child: Text(
                                  'FAVORITE',
                                  style: TextStyle(
                                    fontFamily: 'HelveticaNeue',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Flexible(
                      flex: 1,
                      child: TabBarView(
                        children: [
                          MaleVoice(),
                          const FemaleVoice(),
                          const FavouriteMusic(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
