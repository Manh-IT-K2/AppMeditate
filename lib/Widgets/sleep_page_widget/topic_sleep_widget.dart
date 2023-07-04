import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/data/data_controller.dart';
import 'package:meditation_app/Common/screen/detail_meditation_screen.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/music_controller.dart';
import 'package:meditation_app/controller/sleep_controller.dart';
import 'package:meditation_app/model/sleep_model.dart';

class TopicSleepWidget extends StatelessWidget {
  const TopicSleepWidget({
    super.key,
    required this.sTextTitle,
    required this.sTextSubtitle,
});
  final double sTextTitle, sTextSubtitle;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SleepController());
    final dataController = Get.put(DataController());
    final controllerMusic = Get.put(MusicController());
    return FutureBuilder<List<SleepModel>>(
      future: controller.getSleepList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // nếu không có dữ liệu thì hiện vòng xoay
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final sleeps = snapshot.data!;
        return MasonryGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10, // cách đều bên phải trái
          mainAxisSpacing: 16, // cách đều trên dưới
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          itemCount: sleeps.length,
          itemBuilder: (context, index) {
            final sleep = sleeps[index];
            return InkWell(
              // nhấn vào sẽ chuyển sang trang reminderspage
              onTap: () {
                Get.to(() => MeditationDetailPage(
                  icon: Icons.mode_night,
                  colorText: Colors.white,
                  colorItem: const Color.fromARGB(255, 28, 35, 86),
                  backgroundColor: const Color(0xFF1F265E),
                  future: controllerMusic.getMusicSleep(sleep.id),
                ), arguments: {
                  "titleMeditation": dataController.titleSleep.value = sleep.title
                });
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: sleep.colorBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LayoutBuilder(
                      // đọc được contraints của thằng cha cho thằng con
                      builder: (context, constraints) {
                        return Image.asset(
                          sleep.thumbnail,
                          width: constraints.maxWidth,
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: RichText(
                        text: TextSpan(
                          text: '${sleeps[index].title}\n',
                          style: Primaryfont.bold(
                                  sTextTitle)
                              .copyWith(color: sleep.textColor),
                          children: [
                            TextSpan(
                              text: sleeps[index].timeSleep,
                              style: Primaryfont.ligh(sTextSubtitle).copyWith(
                                  color: kColorLightGrey, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}