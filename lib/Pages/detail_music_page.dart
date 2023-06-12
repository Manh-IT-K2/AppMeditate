import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:just_audio/just_audio.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/editprofile_controller.dart';
import 'package:meditation_app/controller/statistical_controller.dart';
import 'package:meditation_app/model/statistical_model.dart';

class DetailMusic extends StatefulWidget {
  const DetailMusic({
    required this.imageBg,
    required this.color,
    required this.bgColor,
    required this.imageForward,
    required this.imageRelay,
    super.key,
  });
  final String imageBg, imageRelay, imageForward;
  final Color color, bgColor;
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
  late final String musicId = arguments["musicId"];
  final AudioPlayer advancedPlayer = AudioPlayer();
  Duration _duration = const Duration();
  Duration _position = const Duration();

  final controllerStatistical = Get.put(StatisticalController());
  final user = Get.put(EditProfileController());
  int view = 0;
  int favourite = 0;
  int download = 0;
  late bool checkFavourite;
  late bool checkLike;

  late AnimationController _animationController;
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;
  int secondsMusic = 0;
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
    advancedPlayer.setUrl(musicUrl);

    super.initState();
  }

  // @override
  // void dispose(){
  //   advancedPlayer.dispose();
  //   _animationController.dispose();
  //   controllerStatistical.dispose();
  //   user.dispose();
  //   super.dispose();
  // }

  // update view
  void updateView() async {
    if (isPlaying == true) {
      view += 1;
    } else {
      view = 0;
    }
    final idUser = await user.getUser();
    if (await controllerStatistical.checkStatistical(musicId)) {
      final statisticals =
          await controllerStatistical.getDetailStatistical(musicId);
      String id = statisticals.id ?? "";
      int totalView = statisticals.view!;
      totalView += view;
      await controllerStatistical.addIdUser(id, "${idUser.id}02");
      await controllerStatistical.updateViewStatistical(id, totalView);
    } else {
      StatisticalModel statistical = StatisticalModel(
          view: view,
          idUser: ["${idUser.id}02"],
          favourite: favourite,
          download: download,
          idMusic: musicId);
      controllerStatistical.createStatistical(statistical);
    }
  }

  // update view
  updateFavourite() async {
    final idUser = await user.getUser();
    if (await controllerStatistical.checkStatistical(musicId)) {
      final statisticals =
          await controllerStatistical.getDetailStatistical(musicId);
      String id = statisticals.id ?? "";
      int totalFavourite = statisticals.favourite!;
      if (checkLike == true) {
        favourite -= 1;
        totalFavourite += favourite;
        await controllerStatistical.deleteIdUser(id);
      } else {
        totalFavourite += 1;
        await controllerStatistical.addIdUser(id, idUser.id!);
      }
      await controllerStatistical.updateFavouriteStatistical(
          id, totalFavourite);
    } else {
      favourite += 1;
      StatisticalModel statistical = StatisticalModel(
          view: view,
          idUser: ["${idUser.id}"],
          favourite: favourite,
          download: download,
          idMusic: musicId);
      controllerStatistical.createStatistical(statistical);
    }
    favourite = 0;
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
        if (advancedPlayer.position > Duration.zero) {
          if (advancedPlayer.position < const Duration(seconds: 10)) {
            advancedPlayer
                .seek(advancedPlayer.position - advancedPlayer.position);
            advancedPlayer.play();
          } else {
            advancedPlayer
                .seek(advancedPlayer.position - const Duration(seconds: 10));
            advancedPlayer.play();
          }
          _animationController.repeat();
          advancedPlayer.play();
          setState(() {
            isPlaying = true;
          });
          //
        }
      },
      child: Image(
        image: AssetImage(widget.imageRelay),
        width: 40,
        height: 40,
      ),
    );
  }

  // next music
  Widget btnNext() {
    return InkWell(
      onTap: () {
        if (_position.inSeconds.toDouble() < _duration.inSeconds.toDouble()) {
          double a =
              _duration.inSeconds.toDouble() - _position.inSeconds.toDouble();
          if (a < 10.0) {
            int b = a.toInt();
            advancedPlayer.seek(advancedPlayer.position + Duration(seconds: b));
            advancedPlayer.play();
          } else {
            advancedPlayer
                .seek(advancedPlayer.position + const Duration(seconds: 10));
            advancedPlayer.play();
          }
          _animationController.repeat();
          advancedPlayer.play();
          setState(() {
            isPlaying = true;
          });
        } else {
          advancedPlayer.load();
          isPlaying = true;
          _animationController.repeat();
        }
      },
      child: Image(
        image: AssetImage(widget.imageForward),
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
          borderRadius: BorderRadius.circular(40), color: widget.bgColor),
      child: IconButton(
        padding: const EdgeInsets.all(0),
        icon: isPlaying == false
            ? Icon(
                _icons[0],
                size: 70,
                color: widget.color,
              )
            : Icon(
                _icons[1],
                size: 70,
                color: widget.color,
              ),
        onPressed: () async {
          setState(() {
            double a = _position.inSeconds.toDouble();
            if (isPlaying == false) {
              _animationController.repeat();
              isPlaying = true;
              advancedPlayer.play();
              if (a == _duration.inSeconds.toDouble()) {
                advancedPlayer.load();
              }
            } else {
              _animationController.stop();
              isPlaying = false;
              advancedPlayer.pause();
            }
          });
          //
          updateView();
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
      data: const SliderThemeData(trackHeight: 8),
      child: Slider(
        activeColor: widget.color,
        inactiveColor: Colors.grey[400],
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(
            () {
              changeToSecond(value.toInt());
              value = value;
              advancedPlayer.play();
              _animationController.repeat();
              isPlaying = true;
            },
          );
          //
        },
      ),
    );
  }

  Widget turntable() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: widget.bgColor,
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
                      image: NetworkImage(musicImage),
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
    secondsMusic = second;
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      backgroundColor: widget.bgColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height / 4,
            child: Image.network(
              musicImage,
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            left: 20,
            right: 20,
            child: AppBar(
              leading: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: IconButton(
                  alignment: Alignment.center,
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                  iconSize: 30,
                ),
              ),
              actions: [
                FutureBuilder(
                  future: controllerStatistical.checkFavourite(musicId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      if (kDebugMode) {
                        print("Error: ${snapshot.error}");
                      }
                    }
                    checkFavourite = snapshot.data ?? false;
                    checkLike = checkFavourite;
                    return CircleAvatar(
                      radius: 20,
                      backgroundColor: const Color.fromRGBO(34, 34, 34, 0.475),
                      child: IconButton(
                        alignment: Alignment.center,
                        onPressed: () async {
                          await updateFavourite();
                          setState(() {
                            checkLike = !checkLike;
                          });
                        },
                        icon: checkLike
                            ? Image.asset(imgCourseDetailHeartSelected)
                            : Image.asset(imgCourseDetailHeart),
                        iconSize: 20,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color.fromRGBO(34, 34, 34, 0.475),
                  child: IconButton(
                    alignment: Alignment.center,
                    onPressed: () {},
                    icon: Image.asset(imgCourseDetailDowload),
                    iconSize: 20,
                  ),
                ),
              ],
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
                      image: AssetImage(widget.imageBg), fit: BoxFit.cover)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  turntable(),
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.center,
                    child: Text(
                      musicTitle,
                      style: Primaryfont.bold(30).copyWith(color: Colors.black),
                    ),
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
                              .copyWith(color: widget.color),
                        ),
                        Text(
                          _formatDuration(_duration),
                          style: Primaryfont.medium(15)
                              .copyWith(color: widget.color),
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
