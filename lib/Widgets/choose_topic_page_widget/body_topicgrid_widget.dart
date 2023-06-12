import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Pages/reminders_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/topics_contronller.dart';
import 'package:meditation_app/model/topics_model.dart';

class BodyTopicGridWidget extends StatefulWidget {
  const BodyTopicGridWidget({
    super.key,
  });

  @override
  State<BodyTopicGridWidget> createState() => _BodyTopicGridWidgetState();
}

class _BodyTopicGridWidgetState extends State<BodyTopicGridWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userName = Get.arguments;
    final size = context.screenSize;
    final controller = Get.put(TopicController());
    return FutureBuilder<List<TopicsModel>>(
      future: controller.getTopicList(),
      builder: (context, snapshot) {
        // if(snapshot.hasError){
        //   print(snapshot.error.toString());
        // }
        //print(snapshot.data);
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
        final topics = snapshot.data!;
        return MasonryGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16, // cách đều bên phải trái
          mainAxisSpacing: 16, // cách đều trên dưới
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          itemCount: topics.length,
          itemBuilder: (context, index) {
            final topic = topics[index];
            return InkWell(
              // nhấn vào sẽ chuyển sang trang reminderspage
              onTap: () {
                //Navigator.of(context).pushNamed('$RemindersPage');
                controller.saveChoseTopic(topic.id);
                Get.off(() => const RemindersPage(), arguments: userName);
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: topic.colorBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LayoutBuilder(
                        // đọc được contraints của thằng cha cho thằng con
                        builder: (context, constraints) {
                      return SvgPicture.asset(
                        topic.thumbnail,
                        width: constraints.maxWidth,
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        topics[index].title,
                        style: Primaryfont.bold(
                                context.screenSize.shortestSide * 0.04)
                            .copyWith(color: topic.textColor),
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
