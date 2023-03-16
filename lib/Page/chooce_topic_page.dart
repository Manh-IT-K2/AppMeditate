import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditation_app/Page/reminders_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/reponsive_builder.dart';
import 'package:meditation_app/data/topic_storage.dart';
import 'package:meditation_app/model/topicmodel.dart';

final topicStorage = AssetTopicStorage();

class ChooseTopicPage extends StatelessWidget {
  const ChooseTopicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ReponsiveBuilder(
          portrait: Column(
            children: const [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: _Header(),
              ),
              Flexible(
                flex: 3,
                child: _TopicGrid(),
              ),
            ],
          ),
          landscape: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(
                  children: const [
                    Expanded(child: _Header()),
                    Spacer(),
                  ],
                ),
              ),
              const Flexible(
                flex: 2,
                child: _TopicGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopicGrid extends StatelessWidget {
  const _TopicGrid({
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
              });
        });
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(
            flex: 3,
          ),
          Flexible(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, //làm cho thằng con rộng hết chiều rộng ra
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // thêm khoảng trống đều ở phía trên và phía dưới những thằng con
              children: [
                Expanded(
                  child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'What Brings you',
                        style: Primaryfont.bold(28),
                      )),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'to silent Moon?',
                        style: Primaryfont.ligh(24),
                      )),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Flexible(
              flex: 1,
              child: FittedBox(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choose a topic to focus on:",
                  style: Primaryfont.ligh(20)
                      .copyWith(color: const Color(0xFFA1A4B2)),
                ),
              )),
          const Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }
}
