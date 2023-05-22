import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:just_audio/just_audio.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Utils/theme.dart';

import '../Constant/colors.dart';
import '../Constant/image_string.dart';

class DetailMusic extends StatefulWidget {
  const DetailMusic({
    super.key,
  });

  @override
  State<DetailMusic> createState() => _DetailMusicState();
}

class _DetailMusicState extends State<DetailMusic>
    with SingleTickerProviderStateMixin {
  final Map arguments = Get.arguments;
  late final String musicImage = arguments["musicImage"];
  late final String musicAuthor = arguments["musicAuthor"];
  late final String musicTitle = arguments["musicTitle"];
  late final String musicUrl = arguments["musicUrl"];
  final AudioPlayer advancedPlayer = AudioPlayer();
  Duration _duration = const Duration();
  Duration _position = const Duration();

  late AnimationController _animationController;
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;
  LoopMode loopMode = LoopMode.off;
  Icon icon = const Icon(
    Icons.repeat,
    color: Colors.black,
    size: 30,
  );

  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];
  // init
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    advancedPlayer.durationStream.listen((event) {
      setState(() {
        _duration = event!;
      });
    });
    advancedPlayer.positionStream.listen((event) {
      setState(() {
        _position = event;
      });
    });
    // Lắng nghe sự kiện thay đổi trạng thái của audio player
    advancedPlayer.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        // Điều khiển đĩa xoay ngừng
        _animationController.stop();
         setState(() {
          isPlaying = false;
        });
      }
    });
    advancedPlayer.setAsset(musicUrl);
  }

  // fomat time music
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  // previous music
  Widget btnPrevious() {
    return InkWell(
      onTap: () {
        advancedPlayer.seek(advancedPlayer.position - const Duration(seconds: 10));
        _animationController.repeat();
        advancedPlayer.play();
         setState(() {
          isPlaying = true;
        });
      },
      child: Image(
        image: AssetImage(imgMusicIconRelay),
        width: 50,
        height: 50,
      ),
    );
  }

  // next music
  Widget btnNext() {
    return InkWell(
      onTap: () {
        advancedPlayer.seek(advancedPlayer.position + const Duration(seconds: 10));
        _animationController.repeat();
        advancedPlayer.play();
        setState(() {
          isPlaying = true;
        });
      },
      child: Image(
        image: AssetImage(imgMusicIconSkip),
        width: 40,
        height: 40,
      ),
    );
  }

  // repeat music
  Widget btnRepeat() {
    return IconButton(
        onPressed: () {
          toggleLoopMode();
        },
        icon: icon);
  }

  // random music
  Widget btnRandom() {
    return IconButton(
      onPressed: () {
        advancedPlayer.shuffle();
      },
      icon: const Icon(
        Icons.shuffle,
        color: Colors.black,
        size: 30,
      ),
    );
  }

  // play or pause music
  Widget btnStart() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: kColorLightGrey),
      child: IconButton(
        padding: const EdgeInsets.all(0),
        icon: isPlaying == false
            ? Icon(
                _icons[0],
                size: 70,
                color: Colors.black,
              )
            : Icon(
                _icons[1],
                size: 70,
                color: Colors.black,
              ),
        onPressed: () {
          setState(() {
            double a =  _position.inSeconds.toDouble();
            if (isPlaying == false) {
              _animationController.repeat();
              isPlaying = true;
              advancedPlayer.play();
              
              if(a ==  _duration.inSeconds.toDouble()){
                advancedPlayer.load();
              }
            } else {
               _animationController.stop();
              isPlaying = false;
              advancedPlayer.pause();
             
            }
          });
        },
      ),
    );
  }

  // chuyển chế độ vòng lặp
  void toggleLoopMode() {
    switch (loopMode) {
      case LoopMode.off:
        loopMode = LoopMode.one;
        icon = const Icon(
          Icons.repeat_one,
          color: Colors.white,
          size: 30,
        );
        break;
      case LoopMode.one:
        loopMode = LoopMode.all;
        icon = const Icon(
          Icons.repeat,
          color: Colors.white,
          size: 30,
        );
        break;
      case LoopMode.all:
        loopMode = LoopMode.off;
        icon = const Icon(
          Icons.repeat,
          color: Colors.black,
          size: 30,
        );
        break;
    }
    advancedPlayer.setLoopMode(loopMode);
  }

  Widget loadAsset() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //btnRepeat(),
        btnPrevious(),
        btnStart(),
        btnNext(),
        //btnRandom(),
      ],
    );
  }

  Widget slider() {
    return SliderTheme(
      data: const SliderThemeData(
        trackHeight: 8
      ),
      child: Slider(
          activeColor: Colors.black,
          inactiveColor: Colors.grey[400],
          value: _position.inSeconds.toDouble(),
          min: 0.0,
          max: _duration.inSeconds.toDouble(),
          onChanged: (double value) {
            setState(() {
              changeToSecond(value.toInt());
              value = value;
              advancedPlayer.play();
              _animationController.repeat();
              isPlaying = true;
            });
          }),
    );
  }

  Widget turntable() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: kColorLightGrey,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return GestureDetector(
              child: Transform.rotate(
                angle: math.pi * 2 * _animationController.value,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5), width: 2),
                    image: DecorationImage(
                      image: AssetImage(musicImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      backgroundColor: kColorLightGrey,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height / 4,
            child: Image.asset(
              musicImage,
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              leading: IconButton(
                onPressed: () {
                  Get.off(() => const ContainerPage());
                  SaveChange.indexPage = 3;
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              // actions: [
              //   IconButton(
              //     onPressed: () {},
              //     icon: const Icon(Icons.search),
              //   )
              // ],
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          Positioned(
            top: size.height * 0.2,
            left: 0,
            right: 0,
            height: size.height * 0.75,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                      image: AssetImage(imgMusicsBackGround),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  turntable(),
                  const SizedBox(height: 50),
                  Text(
                    musicTitle,
                    style: Primaryfont.bold(30).copyWith(color: Colors.black),
                  ),
                  Text(
                    musicAuthor,
                    style: Primaryfont.medium(15)
                        .copyWith(color: Colors.black, height: 2),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  loadAsset(),
                  const SizedBox(
                    height: 50,
                  ),
                  slider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(_position),
                          style: Primaryfont.bold(15)
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          _formatDuration(_duration),
                          style: Primaryfont.medium(15)
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
