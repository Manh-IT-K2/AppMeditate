import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meditation_app/Common/widget/neubox_widget.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/detail_music_page_widget/appbar_detail_music_widget.dart';
import 'package:meditation_app/Widgets/detail_music_page_widget/body_detail_music_widget.dart';
import 'package:meditation_app/Widgets/detail_music_page_widget/control_detail_music_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DarkMode {
  static ValueNotifier<bool> darkLight = ValueNotifier<bool>(false);
  static AudioPlayer play = AudioPlayer();
}

class DetailMusic extends StatefulWidget {
  const DetailMusic(
      {super.key,
      required this.nameSong,
      required this.duration,
      required this.image});

  final String nameSong, image, duration;
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
  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  State<DetailMusic> createState() => _DetailMusicState();
}

class _DetailMusicState extends State<DetailMusic> {
  final ValueNotifier<bool> _isplay = ValueNotifier<bool>(false);
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  Widget build(BuildContext context) {
    //final listSong = ModalRoute.of(context)!.settings.arguments;
    return ValueListenableBuilder(
      valueListenable: DarkMode.darkLight,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor:
              DarkMode.darkLight.value ? Colors.grey[850] : Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                
                margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                child: Column(
                  children: [
                    AppBarDetailMusicWidget(),
                    const SizedBox(
                      height: 30,
                    ),
                    BodyDetailMusicWidget(widget: widget),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          formatTime(position.inSeconds),
                          style: Primaryfont.bold(15).copyWith(
                              color: DarkMode.darkLight.value
                                  ? Colors.black
                                  : Colors.grey),
                        ),
                        const Icon(Icons.shuffle),
                        const Icon(Icons.repeat),
                        Text(
                          formatTime((duration - position).inSeconds),
                          style: Primaryfont.bold(15).copyWith(
                              color: DarkMode.darkLight.value
                                  ? Colors.black
                                  : Colors.grey),
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
                            progressColor: DarkMode.darkLight.value
                                ? Colors.grey[900]
                                : Colors.pink,
                            backgroundColor: DarkMode.darkLight.value
                                ? Colors.grey[800]
                                : Colors.white,
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
                    ControlDetailMusicWidget(isplay: _isplay, widget: widget),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
