import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:just_audio/just_audio.dart';
import 'package:meditation_app/Common/message/dialog_message.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/current_streak_controller.dart';
import 'package:meditation_app/controller/editprofile_controller.dart';
import 'package:meditation_app/controller/music_controller.dart';
import 'package:meditation_app/controller/statistical_controller.dart';
import 'package:meditation_app/model/currentstreak_model.dart';
import 'package:meditation_app/model/statistical_model.dart';

// get date now
String dateStatistical() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd/MM/yyyy').format(now);
  String formattedDay = DateFormat.E().format(now);
  return "$formattedDay $formattedDate";
}

// String previousDateFormatted() {
//   DateTime now = DateTime.now();
//   DateTime previousDay = now.subtract(Duration(days: 1)); // Lấy ngày trước đó
//   String formattedDate = DateFormat('dd/MM/yyyy').format(previousDay);
//   String formattedDay = DateFormat.E().format(previousDay);
//   return "$formattedDay $formattedDate";
// }

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
  //
  final controllerMusic = Get.put(MusicController());
  //
  final user = Get.put(EditProfileController());
  //
  final currentStreak = Get.put(CurrentStreakController());
  // Tạo một biến để lưu thời gian nghe
  Duration meditationMinute = Duration.zero;
  Timer? listeningTimer;
  int view = 0;
  bool listenedCount = false;
  int favourite = 0;
  int download = 0;
  late bool checkFavourite;
  late bool checkLike;
  late bool checkDownload;
  late bool checkDownloaded;
  late File imageMusicPath;
  int complete = 0;

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
    imageMusicPath = File(musicImage);
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
        listenedCount = true;
        updateMeditationMinute(meditationMinute.inSeconds, listenedCount, "LC");
        if (mounted) {
          setState(() {
            isPlaying = false;
            meditationMinute = Duration.zero;
            listeningTimer!.cancel();
          });
        }
      }
    });
    if (SaveChange.checkMusicImage == true) {
      advancedPlayer.setFilePath(musicUrl);
    } else {
      advancedPlayer.setUrl(musicUrl);
    }
    super.initState();
  }

//   @override
// void dispose() {
//   advancedPlayer.dispose();
//   _animationController.dispose();
//   super.dispose();
// }
  void startListeningTime() {
    listeningTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Cập nhật thời gian nghe
      if (mounted) {
        setState(() {
          meditationMinute += const Duration(seconds: 1);
        });
      }
    });
  }

  // update view
  void updateView() async {
    if (isPlaying == true) {
      view += 1;
    } else {
      view = 0;
    }
    final idUser = await user.getUser();
    //String checkDate = statisticals.date ?? "";
    if (await controllerStatistical.checkStatistical(
        musicId, dateStatistical())) {
      final statisticals = await controllerStatistical.getDetailStatistical(
          musicId, dateStatistical());
      if (statisticals.date == dateStatistical()) {
        String id = statisticals.id!;
        int totalView = statisticals.view!;
        totalView += view;
        await controllerStatistical.addIdUser(id, "${idUser!.id}View");
        await controllerStatistical.updateViewStatistical(id, totalView);
      } else {
        StatisticalModel statistical = StatisticalModel(
            meditationMinute: meditationMinute.inSeconds,
            date: dateStatistical(),
            listenedCount: listenedCount,
            view: view,
            idUser: ["${idUser!.id}View"],
            favourite: favourite,
            download: download,
            idMusic: musicId);
        controllerStatistical.createStatistical(statistical);
      }
    } else {
      StatisticalModel statistical = StatisticalModel(
          meditationMinute: meditationMinute.inSeconds,
          date: dateStatistical(),
          listenedCount: listenedCount,
          view: view,
          idUser: ["${idUser!.id}View"],
          favourite: favourite,
          download: download,
          idMusic: musicId);
      controllerStatistical.createStatistical(statistical);
    }
  }

  // update view
  updateFavourite() async {
    final idUser = await user.getUser();
    if (await controllerStatistical.checkStatistical(
        musicId, dateStatistical())) {
      final statisticals = await controllerStatistical.getDetailStatistical(
          musicId, dateStatistical());
      if (statisticals.date == dateStatistical()) {
        String id = statisticals.id ?? "";
        int totalFavourite = statisticals.favourite!;
        if (checkLike == true) {
          favourite -= 1;
          totalFavourite += favourite;
          await controllerStatistical.deleteIdUserFavourite(id);
        } else {
          totalFavourite += 1;
          await controllerStatistical.addIdUser(id, idUser!.id!);
        }
        await controllerStatistical.updateFavouriteStatistical(
            id, totalFavourite);
      }
    } else {
      favourite += 1;
      StatisticalModel statistical = StatisticalModel(
          meditationMinute: 0,
          listenedCount: listenedCount,
          date: dateStatistical(),
          view: view,
          idUser: ["${idUser!.id}"],
          favourite: favourite,
          download: download,
          idMusic: musicId);
      controllerStatistical.createStatistical(statistical);
    }
    favourite = 0;
  }

  updateDownload() async {
    final idUser = await user.getUser();
    if (await controllerStatistical.checkStatistical(
        musicId, dateStatistical())) {
      final statisticals = await controllerStatistical.getDetailStatistical(
          musicId, dateStatistical());
      if (statisticals.date == dateStatistical()) {
        String id = statisticals.id ?? "";
        int totalDownload = statisticals.download!;
        download += 1;
        totalDownload += download;
        //await controllerStatistical.deleteIdUser(id);
        await controllerStatistical.addIdUser(id, "${idUser!.id!}DL");
        await controllerStatistical.updateDownloadStatistical(
            id, totalDownload);
        controllerMusic.downloadMusic(musicUrl, musicImage, musicId);
      }
    } else {
      download += 1;
      StatisticalModel statistical = StatisticalModel(
          meditationMinute: 0,
          listenedCount: listenedCount,
          date: dateStatistical(),
          view: view,
          idUser: ["${idUser!.id}DL"],
          favourite: favourite,
          download: download,
          idMusic: musicId);
      controllerStatistical.createStatistical(statistical);
      controllerMusic.downloadMusic(musicUrl, musicImage, musicId);
    }
  }

  updateMeditationMinute(
      int meditationMinute, bool listenedCount, String idUserr) async {
    final idUser = await user.getUser();
    final statisticals = await controllerStatistical.getDetailStatistical(
        musicId, dateStatistical());
    String id = statisticals.id ?? "";
    if (await controllerStatistical.checkStatistical(
            musicId, dateStatistical()) &&
        statisticals.date == dateStatistical()) {
      await controllerStatistical.addIdUser(id, "${idUser?.id!}$idUserr");
      int totalMeditationMinute = statisticals.meditationMinute!;
      totalMeditationMinute += meditationMinute;
      await controllerStatistical.updateMeditationMinuteStatistical(
          id, totalMeditationMinute);
      await controllerStatistical.updateListenedCountStatistical(
          id, listenedCount);
      if (await currentStreak.checkCurrentStreak(idUser!.id!)) {
        final currentStreakByUser =
            await currentStreak.getCurrentStreakByUser(idUser.id!);
        String idCurrentStreak = currentStreakByUser?.id ?? "";
        int totalCountStreak = currentStreakByUser!.streakCount;

        if (await currentStreak.checkDateCurrentStreak(
            idCurrentStreak, dateStatistical())) {
          currentStreak.addDateNow(idCurrentStreak, dateStatistical());
          totalCountStreak += 1;
          currentStreak.updateCountCurrentStreak(
              idCurrentStreak, totalCountStreak);
        }
        if (await currentStreak.checkDateBehindNow(
            idCurrentStreak, dateStatistical())) {
          currentStreak.addDateNow(idCurrentStreak, dateStatistical());
          currentStreak.updateCountCurrentStreak(idCurrentStreak, 1);
        }
      } else {
        await currentStreak.createCurrentStreak(
          CurrentStreakModel(
              date: [dateStatistical()], userId: idUser.id!, streakCount: 1),
        );
      }
    } else {
      StatisticalModel statistical = StatisticalModel(
          meditationMinute: meditationMinute,
          listenedCount: listenedCount,
          date: dateStatistical(),
          view: view,
          idUser: ["${idUser!.id}$idUserr"],
          favourite: favourite,
          download: download,
          idMusic: musicId);
      controllerStatistical.createStatistical(statistical);
      await controllerStatistical.updateMeditationMinuteStatistical(
          id, meditationMinute);
    }
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
            startListeningTime();
          } else {
            advancedPlayer
                .seek(advancedPlayer.position - const Duration(seconds: 10));
            advancedPlayer.play();
            startListeningTime();
          }
          _animationController.repeat();
          advancedPlayer.play();
          startListeningTime();
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
            startListeningTime();
          } else {
            advancedPlayer
                .seek(advancedPlayer.position + const Duration(seconds: 10));
            advancedPlayer.play();
            startListeningTime();
          }
          _animationController.repeat();
          advancedPlayer.play();
          startListeningTime();
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
              startListeningTime();
              if (a == _duration.inSeconds.toDouble()) {
                advancedPlayer.load();
              }
            } else {
              _animationController.stop();
              isPlaying = false;
              advancedPlayer.pause();
              updateMeditationMinute(
                  meditationMinute.inSeconds, listenedCount, "MM");
              listeningTimer?.cancel();
              meditationMinute = Duration.zero;
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
              startListeningTime();
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
                      image: SaveChange.checkMusicImage
                          ? Image.file(imageMusicPath).image
                          : NetworkImage(musicImage),
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
          SaveChange.checkMusicImage
              ? Image.file(
                  imageMusicPath,
                  width: size.width,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  musicImage,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
          Container(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: AppBar(
              toolbarHeight: 40,
              leading: CircleAvatar(
                radius: 20,
                backgroundColor: const Color.fromRGBO(34, 34, 34, 0.475),
                child: IconButton(
                  alignment: Alignment.center,
                  onPressed: () {
                    Get.back();
                    advancedPlayer.stop();
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  iconSize: 20,
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
                          //  if(SaveChange.checkMusicImage == false){
                          await updateFavourite();
                          setState(() {
                            checkLike = !checkLike;
                          });
                          //}
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
                FutureBuilder(
                  future: controllerStatistical.checkDownload(musicId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      if (kDebugMode) {
                        print("Error: ${snapshot.error}");
                      }
                    }
                    checkDownload = snapshot.data ?? false;
                    checkDownloaded = checkDownload;
                    return CircleAvatar(
                      radius: 20,
                      backgroundColor: const Color.fromRGBO(34, 34, 34, 0.475),
                      child: IconButton(
                        alignment: Alignment.center,
                        onPressed: () async {
                          ConnectivityResult connectivityResult =
                              await (Connectivity().checkConnectivity());
                          if (await user.getDowloadCellular() && connectivityResult == ConnectivityResult.mobile) {
                           if (checkDownload) {
                              // ignore: use_build_context_synchronously
                              DialogMessage.show(
                                  context, "The song has been downloaded");
                            } else {
                              await updateDownload();
                              setState(() {
                                checkDownloaded = !checkDownloaded;
                              });
                            }
                          } else {
                            if(connectivityResult == ConnectivityResult.mobile){
                              // ignore: use_build_context_synchronously
                              DialogMessage.show(
                                context, "Downloading using mobile data is not allowed"
                              );
                            }else{
                              if (checkDownload) {
                              // ignore: use_build_context_synchronously
                              DialogMessage.show(
                                  context, "The song has been downloaded");
                            } else {
                              await updateDownload();
                              setState(() {
                                checkDownloaded = !checkDownloaded;
                              });
                            }
                            }
                          }
                        },
                        icon: checkDownloaded
                            ? Image.asset(imgCourseDetailDownloadSelected)
                            : Image.asset(imgCourseDetailDowload),
                        iconSize: 20,
                      ),
                    );
                  },
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
                      style: Primaryfont.bold(20).copyWith(color: widget.color),
                    ),
                  ),
                  Text(
                    musicAuthor,
                    style: Primaryfont.medium(14)
                        .copyWith(color: widget.color, height: 2),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  loadAsset(),
                  const SizedBox(
                    height: 30,
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
