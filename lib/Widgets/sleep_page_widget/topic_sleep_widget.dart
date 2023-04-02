import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Pages/sleep_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/model/sleepmodel.dart';

class TopicSleepWidget extends StatelessWidget {
  const TopicSleepWidget({
    super.key,
    required this.sTextTitle,
    required this.sTextSubtitle,
});
  final double sTextTitle, sTextSubtitle;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sleep>>(
      future: sleepStorage.Load(),
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
        final Sleeps = snapshot.data!;
        return MasonryGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10, // cách đều bên phải trái
          mainAxisSpacing: 16, // cách đều trên dưới
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          itemCount: Sleeps.length,
          itemBuilder: (context, index) {
            final sleep = Sleeps[index];
            return InkWell(
              // nhấn vào sẽ chuyển sang trang reminderspage
              onTap: () {
                //Navigator.of(context).pushNamed('$RemindersPage');
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: sleep.bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LayoutBuilder(
                      // đọc được contraints của thằng cha cho thằng con
                      builder: (context, Constraints) {
                        return Image.asset(
                          sleep.thumbnail,
                          width: Constraints.maxWidth,
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: RichText(
                        text: TextSpan(
                          text: '${Sleeps[index].title}\n',
                          style: Primaryfont.bold(
                                  sTextTitle)
                              .copyWith(color: sleep.textColor),
                          children: [
                            TextSpan(
                              text: Sleeps[index].timesleep,
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