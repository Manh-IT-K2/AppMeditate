import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/detail_setting_page_widget/detail_setting_notification/callback_dispatcher.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class BedtimeReminderScreen extends StatefulWidget {
  @override
  _BedtimeReminderScreenState createState() => _BedtimeReminderScreenState();
}

class _BedtimeReminderScreenState extends State<BedtimeReminderScreen> {
  String formattedTime = "";
  String formattedDate = '';
  TimeOfDay selectedTimeSleep = const TimeOfDay(hour: 00, minute: 00);
  TimeOfDay selectedTimeWakeUp = const TimeOfDay(hour: 00, minute: 00);
  late DateTime selectedDateTime;
  bool permissionRequested = false;
  @override
  void initState() {
    initNotification();
    // Sử dụng Timer.periodic để cập nhật thời gian sau mỗi giây
    Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();
      formattedTime = DateFormat('hh:mm a').format(now);
      formattedDate = DateFormat.yMMMMd('en_US').format(now);
      if (mounted) {
        setState(() {});
      }
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  // chose time wake up
  void _selectedTimeWakeUp()  async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      // Tạo thời gian kích hoạt thông báo
      setState(() {
        selectedTimeWakeUp = selectedTime;
      });
      await saveTimeOfDayWakeUp(selectedTimeWakeUp);
    }
  }

  // save Time Of Day Sleep with sharedpreferances
  Future<void> saveTimeOfDaySleep(TimeOfDay time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('hourSleep', time.hour);
    await prefs.setInt('minuteSleep', time.minute);
  }

  // get Time Of Day Sleep with sharedpreferances
  Future<TimeOfDay?> getTimeOfDaySleep() async {
    final prefs = await SharedPreferences.getInstance();
    final hour = prefs.getInt('hourSleep');
    final minute = prefs.getInt('minuteSleep');
    if (hour != null && minute != null) {
      return TimeOfDay(hour: hour, minute: minute);
    } else {
      return null; // Trả về null nếu không tìm thấy giá trị trong SharedPreferences
    }
  }

  // save Time Of Day Wake Up with sharedpreferances
  Future<void> saveTimeOfDayWakeUp(TimeOfDay time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('hourWakeUp', time.hour);
    await prefs.setInt('minuteWakeUp', time.minute);
  }

  // get Time Of Day Wake Up with sharedpreferances
  Future<TimeOfDay?> getTimeOfDayWakeUp() async {
    final prefs = await SharedPreferences.getInstance();
    final hour = prefs.getInt('hourWakeUp');
    final minute = prefs.getInt('minuteWakeUp');
    if (hour != null && minute != null) {
      return TimeOfDay(hour: hour, minute: minute);
    } else {
      return null; // Trả về null nếu không tìm thấy giá trị trong SharedPreferences
    }
  }

  // chose bedtime sleep
  Future<void> _selectedTimeSleep() async {
    // Hỏi người dùng chọn thời gian
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      // Tạo thời gian kích hoạt thông báo
      setState(() {
        selectedTimeSleep = selectedTime;
      });
      await saveTimeOfDaySleep(selectedTimeSleep);
      DateTime now = DateTime.now();
      DateTime scheduledTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      // Đặt lịch chạy công việc
      Workmanager().cancelByUniqueName(
          "showNotificationTask"); // Hủy tất cả các công việc cũ
      Workmanager().registerOneOffTask(
        "showNotification", // Tên công việc
        "showNotificationTask", // Tên task
        initialDelay:
            scheduledTime.difference(now), // Khoảng thời gian trì hoãn
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final currentTime = DateTime.now();
    final currentHour = currentTime.hour;

    // set up image, text, color to day
    String greetingText;
    String greetingImage;
    Color greetingColorText,
        colorBoxshadowCirle,
        colorBoxshadowCirleAbove,
        colorBoxshadowCirleBelow;
    if (currentHour >= 6 && currentHour < 18) {
      greetingText = translation(context).txtGoodMorning;
      greetingImage = imgBgBedtimeMorning;
      greetingColorText = Colors.black;
      colorBoxshadowCirle = const Color.fromARGB(255, 238, 131, 43);
      colorBoxshadowCirleAbove = const Color.fromARGB(255, 243, 122, 0);
      colorBoxshadowCirleBelow = const Color.fromARGB(255, 221, 201, 48);
    } else {
      greetingText = translation(context).txtGoodEvening;
      greetingImage = imgBgBedtimeSleep;
      greetingColorText = Colors.white;
      colorBoxshadowCirle = const Color.fromARGB(255, 255, 254, 254);
      colorBoxshadowCirleAbove = const Color.fromARGB(255, 227, 228, 231);
      colorBoxshadowCirleBelow = const Color.fromARGB(255, 126, 126, 132);
    }
    return Scaffold(
      backgroundColor: kColorLightGrey,
      body: Stack(
        children: [
          Image.asset(
            greetingImage,
            height: size.height,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 25,
            child: IconButton(
              onPressed: () {},
              icon: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: greetingColorText,
                ),
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 50,
            child: Center(
              child: Text(
                greetingText,
                style:
                    Primaryfont.medium(24).copyWith(color: greetingColorText),
              ),
            ),
          ),
          Positioned(
              top: 110,
              left: 55,
              child: Row(
                children: [
                  Text(
                    formattedTime,
                    style:
                        Primaryfont.bold(14).copyWith(color: greetingColorText, height: 1.8),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    formattedDate,
                    style:
                        Primaryfont.bold(10).copyWith(color: greetingColorText),
                  ),
                ],
              )),
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      constraints: const BoxConstraints.expand(),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: colorBoxshadowCirle.withOpacity(.2),
                            blurRadius: 32,
                            offset: const Offset(100, 20),
                          ),
                          BoxShadow(
                            color: colorBoxshadowCirle.withOpacity(1),
                            blurRadius: 32,
                            offset: const Offset(0, 0),
                          ),
                        ],
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            colorBoxshadowCirleAbove,
                            colorBoxshadowCirleBelow,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    Container(
                      width: 145,
                      height: 145,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: colorBoxshadowCirle.withOpacity(.2),
                            blurRadius: 32,
                            offset: const Offset(10, 5),
                          ),
                          BoxShadow(
                            color: colorBoxshadowCirle.withOpacity(1),
                            blurRadius: 32,
                            offset: const Offset(0, 0),
                          ),
                        ],
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            colorBoxshadowCirleAbove,
                            colorBoxshadowCirleBelow,
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: pi / 2,
                      child: Container(
                        constraints: const BoxConstraints.expand(),
                        child: CustomPaint(
                          painter: ClockPainter(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 450,
            child: Container(
              width: size.width,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width / 2 - 25,
                    height: 150,
                    decoration: BoxDecoration(
                      color: kColorLightGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          translation(context).txtBedTime,
                          style: Primaryfont.ligh(14)
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FutureBuilder<TimeOfDay?>(
                          future: getTimeOfDaySleep(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              if (kDebugMode) {
                                print("Error get time : ${snapshot.error}");
                              }
                              return const SizedBox();
                            } else if (snapshot.hasData) {
                              final time = snapshot.data;
                              return Text(
                                time!.format(context).toString(),
                                style: Primaryfont.bold(20)
                                    .copyWith(color: Colors.black),
                              );
                            } else {
                              return Text(
                                translation(context).txtLoading,
                                style: Primaryfont.bold(10)
                                    .copyWith(color: Colors.grey),
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: IconButton(
                            onPressed: () async {
                              
                              if (Platform.isAndroid || Platform.isIOS) {
                                var status =
                                    await Permission.notification.status;
                                if (status.isGranted) {
                                  initNotification();
                                  _selectedTimeSleep();
                                } else if (status.isDenied) {
                                  if (!permissionRequested) {
                                    var requestStatus =
                                        await Permission.notification.request();
                                    if (requestStatus.isGranted) {
                                      initNotification();
                                      _selectedTimeSleep();
                                    } else {
                                      permissionRequested = true;
                                    }
                                  } else {
                                    openAppSettings();
                                  }
                                }
                              } else {
                                initNotification();
                                _selectedTimeSleep();
                              }
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.green,
                              size: 30,
                            ),
                            padding: EdgeInsets
                                .zero, // Xóa padding mặc định của IconButton
                            alignment: Alignment
                                .center, // Canh chỉnh biểu tượng vào giữa
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width / 2 - 25,
                    height: 150,
                    decoration: BoxDecoration(
                      color: kColorLightGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          translation(context).txtWakeUp,
                          style: Primaryfont.ligh(14)
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FutureBuilder<TimeOfDay?>(
                          future: getTimeOfDayWakeUp(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              if (kDebugMode) {
                                print("Error get time : ${snapshot.error}");
                              }
                              return const SizedBox();
                            } else if (snapshot.hasData) {
                              final time = snapshot.data;
                              return Text(
                                time!.format(context).toString(),
                                style: Primaryfont.bold(20)
                                    .copyWith(color: Colors.black),
                              );
                            } else {
                              return Text(
                               translation(context).txtLoading,
                                style: Primaryfont.bold(10)
                                    .copyWith(color: Colors.grey),
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: IconButton(
                            onPressed: () async{
                              _selectedTimeWakeUp();
                              await saveTimeOfDayWakeUp(selectedTimeWakeUp);
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.green,
                              size: 30,
                            ),
                            padding: EdgeInsets
                                .zero, // Xóa padding mặc định của IconButton
                            alignment: Alignment
                                .center, // Canh chỉnh biểu tượng vào giữa
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 495,
            left: 60,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromARGB(255, 88, 102, 213),
              ),
              child: const Icon(
                Icons.mode_night,
                color: Colors.black,
                size: 50,
              ),
            ),
          ),
          Positioned(
            top: 495,
            right: 60,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromARGB(255, 206, 206, 188),
              ),
              child: const Icon(
                Icons.sunny,
                color: Colors.yellow,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    double radius = min(centerY, centerX);

    Paint dashPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    Paint secdashPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    double outerRadius = radius - 20;
    double innerRadius = radius - 30;
    for (int i = 0; i < 360; i += 30) {
      double x1 = centerX - outerRadius * cos(i * pi / 180);
      double y1 = centerX - outerRadius * sin(i * pi / 180);
      double x2 = centerX - innerRadius * cos(i * pi / 180);
      double y2 = centerX - innerRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashPaint);
    }
    for (int i = 0; i < 360; i += 6) {
      double x1 = centerX - outerRadius * .95 * cos(i * pi / 180);
      double y1 = centerX - outerRadius * .95 * sin(i * pi / 180);
      double x2 = centerX - innerRadius * cos(i * pi / 180);
      double y2 = centerX - innerRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), secdashPaint);
    }

    DateTime dateTime = DateTime.now();

    Offset secondStartOffset = Offset(
      centerX - outerRadius * cos(dateTime.second * 6 * pi / 180),
      centerX - outerRadius * sin(dateTime.second * 6 * pi / 180),
    );
    Offset secondEndOffset = Offset(
      centerX + 20 * cos(dateTime.second * 6 * pi / 180),
      centerX + 20 * sin(dateTime.second * 6 * pi / 180),
    );

    Offset minStartOffset = Offset(
      centerX - outerRadius * .6 * cos(dateTime.minute * 6 * pi / 180),
      centerX - outerRadius * .6 * sin(dateTime.minute * 6 * pi / 180),
    );
    Offset minEndOffset = Offset(
      centerX + 20 * cos(dateTime.minute * 6 * pi / 180),
      centerX + 20 * sin(dateTime.minute * 6 * pi / 180),
    );

    Offset hourStartOffset = Offset(
      centerX - outerRadius * .4 * cos(dateTime.hour * 6 * pi / 180),
      centerX - outerRadius * .4 * sin(dateTime.hour * 6 * pi / 180),
    );
    Offset hourEndOffset = Offset(
      centerX + 20 * cos(dateTime.hour * 6 * pi / 180),
      centerX + 20 * sin(dateTime.hour * 6 * pi / 180),
    );

    Paint centerCirclePaint = Paint()..color = const Color(0xFFE81466);
    Paint secondPaint = Paint()
      ..color = const Color(0xFFE81466)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    Paint minPaint = Paint()
      ..color = const Color(0xFFBEC5D5)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    Paint hourPaint = Paint()
      ..color = const Color(0xFF222E63)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(minStartOffset, minEndOffset, minPaint);
    canvas.drawLine(hourStartOffset, hourEndOffset, hourPaint);
    canvas.drawLine(secondStartOffset, secondEndOffset, secondPaint);
    canvas.drawCircle(center, 4, centerCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
