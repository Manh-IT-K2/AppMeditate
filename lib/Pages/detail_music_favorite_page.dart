import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meditation_app/Common/widget/neubox_widget.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/detail_music_page_widget/appbar_detail_music_widget.dart';
import 'package:meditation_app/Widgets/detail_music_page_widget/body_detail_music_widget.dart';
import 'package:meditation_app/Widgets/detail_music_page_widget/control_detail_music_widget.dart';

class DarkMode {
  static ValueNotifier<bool> darkLight = ValueNotifier<bool>(false);
  static AudioPlayer play = AudioPlayer(); 
}

class DetailMusicFavorite extends StatefulWidget {
  const DetailMusicFavorite(
      {super.key,
      required this.nameSong,
      required this.duration,
      required this.image});

  final String nameSong, image, duration;
  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  State<DetailMusicFavorite> createState() => _DetailMusicFavoriteState();
}

class _DetailMusicFavoriteState extends State<DetailMusicFavorite> {
  final ValueNotifier<bool> _isplay = ValueNotifier<bool>(false);
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double _sliderValue = 0;

  Duration? _totalDuration;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  void initState() {
    super.initState();
    DarkMode.play.setUrl(widget.duration);
    DarkMode.play.load();
    _initAudioPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    DarkMode.play.dispose();
  }

  Future<void> _initAudioPlayer() async {
    try {
      await DarkMode.play.setUrl(widget.duration);
      DarkMode.play.durationStream.listen((duration) {
        setState(() {
          _duration = duration!;
        });
      });
      DarkMode.play.positionStream.listen((position) {
        setState(() {
          _position = position;
        });
      });
    } catch (e) {
      // handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: DarkMode.darkLight,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor:
              DarkMode.darkLight.value ? Colors.grey[850] : Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    AppBarDetailMusicFavoriteWidget(),
                    const SizedBox(
                      height: 30,
                    ),
                    BodyDetailMusicFavoriteWidget(widget: widget),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StreamBuilder<Duration>(
                          stream: DarkMode.play.positionStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<Duration> snapshot) {
                            if (snapshot.hasData) {
                              final duration = snapshot.data!;
                              return Text(
                                formatTime((duration).inSeconds),
                                style: Primaryfont.bold(15).copyWith(
                                    color: DarkMode.darkLight.value
                                        ? Colors.black
                                        : Colors.grey),
                              );
                            } else {
                              return const Text('0:00');
                            }
                          },
                        ),
                        const Icon(Icons.shuffle),
                        const Icon(Icons.repeat),
                        StreamBuilder<Duration?>(
                          stream: DarkMode.play.durationStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.hasData != null) {
                              _totalDuration = snapshot.data;
                            } else {
                              return const Text('0:00');
                            }
                            return Text(
                              formatTime((_totalDuration)!.inSeconds),
                              style: Primaryfont.bold(15).copyWith(
                                  color: DarkMode.darkLight.value
                                      ? Colors.black
                                      : Colors.grey),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    NeuBox(
                      child: StreamBuilder<Duration>(
                        stream: DarkMode.play.positionStream,
                        builder: (context, snapshot) {
                          final position = snapshot.data ?? Duration.zero;
                          _sliderValue = position.inSeconds.toDouble();
                          return SizedBox(
                            height: 25,
                            child: SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 10,
                                inactiveTrackColor: DarkMode.darkLight.value
                                    ? Colors.grey[900]
                                    : Colors.pink,
                                activeTrackColor: DarkMode.darkLight.value
                                    ? Colors.grey[800]
                                    : Colors.white,
                                thumbColor: DarkMode.darkLight.value
                                    ? Colors.grey[800]
                                    : Colors.white,
                              ),
                              child: Slider(
                                value: _sliderValue,
                                min: 0,
                                max: _duration.inSeconds.toDouble(),
                                onChanged: (double value) {
                                  setState(() {
                                    _sliderValue = value;
                                  });
                                  DarkMode.play
                                      .seek(Duration(seconds: value.toInt()));
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ControlDetailMusicFavoriteWidget(isplay: _isplay, widget: widget),
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
