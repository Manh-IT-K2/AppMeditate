import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditation_app/Pages/chooce_topic_page.dart';
import 'package:meditation_app/Pages/reminders_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/model/topicmodel.dart';

class BodyTopicGridWidget extends StatelessWidget {
  const BodyTopicGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: topicStorage.Load(),
      builder: (context, snapshot) {
        // if(snapshot.hasError){
        //   print(snapshot.error.toString());
        // }
        //print(snapshot.data);
        if (!snapshot.hasData) {
          // nếu không có dữ liệu thì hiện vòng xoay
          return const Center(
            child: CircularProgressIndicator(),
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
                Navigator.of(context).pushNamed('$RemindersPage');
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: topic.bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LayoutBuilder(
                        // đọc được contraints của thằng cha cho thằng con
                        builder: (context, Constraints) {
                      return SvgPicture.asset(
                        topic.thumbnail,
                        width: Constraints.maxWidth,
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
