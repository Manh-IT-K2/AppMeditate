import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditation_app/Pages/meditate_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/model/meditatemodel.dart';

class TopicMeditateWidget extends StatelessWidget {
  const TopicMeditateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //FutureBuilder cập nhật chế độ xem khi dữ liệu đến
    return FutureBuilder<List<Meditate>>(
      future: meditateStorage.Load(),
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
        final Meditates = snapshot.data!;
        return MasonryGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10, // cách đều bên phải trái
          mainAxisSpacing: 16, // cách đều trên dưới
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          itemCount: Meditates.length,
          itemBuilder: (context, index) {
            final meditate = Meditates[index];
            return InkWell(
              // nhấn vào sẽ chuyển sang trang reminderspage
              onTap: () {
                //Navigator.of(context).pushNamed('$RemindersPage');
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: meditate.bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LayoutBuilder(
                      // đọc được contraints của thằng cha cho thằng con
                      builder: (context, Constraints) {
                        return SvgPicture.asset(
                          meditate.thumbnail,
                          width: Constraints.maxWidth,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        Meditates[index].title,
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
