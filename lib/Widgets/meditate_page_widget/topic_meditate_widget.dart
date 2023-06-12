import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/data/data_controller.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/meditate_page_widget/meditation_detail_page.dart';
import 'package:meditation_app/controller/meditate_controller.dart';
import 'package:meditation_app/model/meditation_model.dart';

class TopicMeditateWidget extends StatefulWidget {
  const TopicMeditateWidget({
    super.key,
  });

  @override
  State<TopicMeditateWidget> createState() => _TopicMeditateWidgetState();
}

class _TopicMeditateWidgetState extends State<TopicMeditateWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MeditionController());
    final dataController = Get.put(DataController());
    final size = context.screenSize;
    //FutureBuilder cập nhật chế độ xem khi dữ liệu đến
    return FutureBuilder<List<MeditationModel>>(
      future: controller.getMeditateList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // nếu không có dữ liệu thì hiện vòng xoay
          return SizedBox(
            width: size.width,
            height: size.height,
            child: Align(
              alignment: Alignment.center,
              child: SpinKitFadingCircle(
                color: Colors.pink,
                size: 50.0,
                controller: _animationController,
              ),
            ),
          );
        }
        final meditates = snapshot.data!;
        return MasonryGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10, // cách đều bên phải trái
          mainAxisSpacing: 16, // cách đều trên dưới
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          itemCount: meditates.length,
          itemBuilder: (context, index) {
            final meditate = meditates[index];
            return InkWell(
              // nhấn vào sẽ chuyển sang trang reminderspage
              onTap: () {
                //Navigator.of(context).pushNamed('$RemindersPage');
                Get.to(() => const MeditationDetailPage(), arguments: {
                  "idMeditation": dataController.idMeditation.value =
                      meditate.id,
                  "titleMeditation": dataController.titleMeditation.value =
                      meditate.title
                });
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: meditate.colorBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LayoutBuilder(
                      // đọc được contraints của thằng cha cho thằng con
                      builder: (context, constraints) {
                        return SvgPicture.asset(
                          meditate.thumbnail,
                          width: constraints.maxWidth,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        meditates[index].title,
                        style: Primaryfont.bold(
                                context.screenSize.shortestSide * 0.04)
                            .copyWith(color: meditate.textColor),
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
