import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Repository/meditate_storage.dart';
import 'package:meditation_app/model/meditatemodel.dart';

final meditateStorage = AssetMeditateStorage();

class MeditatePage extends StatelessWidget {
  const MeditatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorLightGrey,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Meditate',
                style: Primaryfont.bold(24).copyWith(color: Colors.black),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: Text(
                'we can learn how to recognize when our\n minds are doing their normal everyday\n acrobatics.',
                style: Primaryfont.ligh(14)
                    .copyWith(color: kColorDartPrimary, height: 1.3),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const _chooseAppbar(),
            const _TitleSuggest(),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20, top: 15),
                child: _MeditateTopics(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleSuggest extends StatelessWidget {
  const _TitleSuggest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 239, 223, 212),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/bg_dailycalm.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Daily Calm',
                      style: Primaryfont.medium(18).copyWith(
                        color: Colors.black,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      'APR 30 • PAUSE PRACTICE',
                      style: Primaryfont.ligh(10).copyWith(
                        color: kColorDartPrimary,
                        height: 2,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MeditateTopics extends StatelessWidget {
  const _MeditateTopics({
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
                      }),
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
            });
      },
    );
  }
}

class _chooseAppbar extends StatelessWidget {
  const _chooseAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kColorPrimary,
                ),
                child: const Icon(
                  Icons.apps_sharp,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Text(
                'All',
                style: Primaryfont.ligh(16)
                    .copyWith(color: Colors.black, height: 1.8),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kColorDartPrimary,
                ),
                child: const Icon(
                  Icons.favorite_border,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Text(
                'My',
                style: Primaryfont.ligh(16)
                    .copyWith(color: kColorDartPrimary, height: 1.8),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kColorDartPrimary,
                ),
                child: const Icon(
                  Icons.emoji_emotions_outlined,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Text(
                'Anxious',
                style: Primaryfont.ligh(16)
                    .copyWith(color: kColorDartPrimary, height: 1.8),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kColorDartPrimary,
                ),
                child: Image.asset(
                  'assets/images/ic_moon.png',
                ),
              ),
              Text(
                'Sleep',
                style: Primaryfont.ligh(16)
                    .copyWith(color: kColorDartPrimary, height: 1.8),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kColorDartPrimary,
                ),
                child: Image.asset('assets/images/ic_kids.png'),
              ),
              Text(
                'Kids',
                style: Primaryfont.ligh(16)
                    .copyWith(color: kColorDartPrimary, height: 1.8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
