import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:meditation_app/Page/course_details_page.dart';
import 'package:meditation_app/Utils/theme.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';

final _play = AudioPlayer();
bool darkLight = darkMode.dl;

class darkMode {
  static bool dl = false;
}

class DetailFavorite extends StatefulWidget {
  final String nameSong;
  final image;
  final duration;
  DetailFavorite(
      {super.key, required this.nameSong, this.duration, this.image});

  @override
  State<DetailFavorite> createState() => _DetailFavoriteState();
}

class _DetailFavoriteState extends State<DetailFavorite> {
  bool _isplay = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  // @override
  // void initState() {
  //   super.initState();
  //   play.onPlayerStateChanged.listen((state) {
  //     setState(() {
  //       _isplay = state == PlayerState.playing;
  //     });
  //   });
  //   play.onDurationChanged.listen((newDuration) {
  //     setState(() {
  //       duration = newDuration;
  //     });
  //   });
  //   play.onPositionChanged.listen((newPosition) {
  //     position = newPosition;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //final listSong = ModalRoute.of(context)!.settings.arguments ;
    return Scaffold(
      backgroundColor: darkLight ? Colors.grey[850] : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: NeuBox(
                      child: InkWell(
                        onTap: () {
                          _play.stop();
                          Navigator.of(context).pushNamed('$CourseDetails');
                        },
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    ),
                  ),
                  Text('CHILL',
                      style: TextStyle(
                        color: darkLight ? Colors.black : Colors.pink,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'HelveticaNeue',
                      )),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: NeuBox(
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              darkLight = !darkLight;
                            });
                          },
                          child: Icon(darkLight
                              ? Icons.light_mode_outlined
                              : Icons.dark_mode_outlined)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              _background(widget: widget),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    formatTime(position.inSeconds),
                    style: Primaryfont.bold(15).copyWith(color: darkLight? Colors.black: Colors.grey),
                  ),
                  const Icon(Icons.shuffle),
                  const Icon(Icons.repeat),
                  Text(
                    formatTime((duration - position).inSeconds),
                    style: Primaryfont.bold(15).copyWith(color: darkLight? Colors.black: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              NeuBox(
                child: SizedBox(
                    height: 25,
                    child: LinearPercentIndicator(
                      lineHeight: 10,
                      percent: 0.5,
                      progressColor: darkLight ? Colors.grey[900] : Colors.pink,
                      backgroundColor:
                          darkLight ? Colors.grey[800] : Colors.white,
                      barRadius: const Radius.circular(20),
                    )
                    // Slider(
                    //     inactiveColor: kColorLightGrey,
                    //     min: 0,
                    //     max: duration.inSeconds.toDouble(),
                    //     value: position.inSeconds.toDouble(),
                    //     onChanged: (value) {
                    //       final position = Duration(seconds: value.toInt());

                    //       _play.seek(position);
                    //       //play.resume();
                    //     }),
                    ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  NeuBox(
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Icon(
                        Icons.skip_previous,
                        size: 32,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SizedBox(
                        height: 80,
                        child: NeuBox(
                          child: InkWell(
                            onTap: () {
                              _play.setAsset(widget.duration);
                              if (_isplay == false) {
                                //play.play(AssetSource("dont coi.mp3"));
                                _play.play();
                                setState(() {
                                  _isplay = true;
                                });
                              } else if (_isplay == true) {
                                _play.pause();
                                setState(() {
                                  _isplay = false;
                                });
                              }
                            },
                            child: Icon(
                              _isplay
                                  ? Icons.motion_photos_pause_outlined
                                  : Icons.play_arrow,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  NeuBox(
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Icon(
                        Icons.skip_next,
                        size: 32,
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

class _background extends StatelessWidget {
  const _background({
    super.key,
    required this.widget,
  });

  final DetailFavorite widget;

  @override
  Widget build(BuildContext context) {
    return NeuBox(
      child: Column(
        children: [
          SizedBox(
            height: 350,
            width: 350,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                widget.image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    widget.nameSong,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.favorite_border,
                  size: 25,
                  color: darkLight ? Colors.black : Colors.pink,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NeuBox extends StatelessWidget {
  final child;
  const NeuBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: child,
      decoration: BoxDecoration(
          color: darkLight ? Colors.grey[850] : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            // right bottom
            BoxShadow(
              color: darkLight ? Colors.grey.shade900 : Colors.grey.shade500,
              blurRadius: 15,
              offset: const Offset(5, 5),
            ),
            //top left
            BoxShadow(
              color: darkLight ? Colors.grey.shade800 : Colors.white,
              blurRadius: 15,
              offset: Offset(-5, -5),
            ),
          ],
          ),
    );
  }
}
