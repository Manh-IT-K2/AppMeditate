import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Repository/sleep_storage.dart';
import 'package:meditation_app/model/sleepmodel.dart';

final sleepStorage = AssetSleepStorage();

class SleepPage extends StatelessWidget {
  const SleepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F265E),
      body: SafeArea(
        child: Column(
          children: const [
            _titleSleep(),
            _appbarSleep(),
            _backgroundSleep(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: _topicSleep(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _topicSleep extends StatelessWidget {
  const _topicSleep();
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
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: RichText(
                        text: TextSpan(
                            text: '${Sleeps[index].title}\n',
                            style: Primaryfont.bold(
                                    context.screenSize.shortestSide * 0.04)
                                .copyWith(color: sleep.textColor),
                            children: [
                              TextSpan(
                                  text: Sleeps[index].timesleep,
                                  style: Primaryfont.ligh(10).copyWith(
                                      color: kColorLightGrey, height: 1.5))
                            ]),
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

class _backgroundSleep extends StatelessWidget {
  const _backgroundSleep();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/bg_sleeppage.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 35,
                  width: 35,
                  margin: const EdgeInsets.only(left: 20, top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 242, 242, 244),
                  ),
                  child: const Icon(
                    Icons.lock_open_outlined,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'The ocean moon\n',
                  style:
                      Primaryfont.bold(24).copyWith(color: kColorLightYellow),
                  children: [
                    TextSpan(
                      text: 'Non-stop 8- hour mixes of our\n',
                      style: Primaryfont.ligh(14)
                          .copyWith(color: Colors.white, height: 2),
                      children: [
                        TextSpan(
                          text: 'most popular sleep audio',
                          style: Primaryfont.ligh(14)
                              .copyWith(color: Colors.white, height: 1.2),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: MaterialButton(
                  onPressed: () {
                    // Navigator.of(context).pushNamed();
                  },
                  color: Colors.white,
                  height: 50,
                  minWidth: 85,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(38),
                  ),
                  child: Text(
                    'START',
                    style: Primaryfont.ligh(14).copyWith(color: Colors.black),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _appbarSleep extends StatelessWidget {
  const _appbarSleep();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 60,
                width: 60,
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
                "All",
                style: Primaryfont.ligh(16)
                    .copyWith(color: Colors.white, height: 1.8),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 60,
                width: 60,
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
                "My",
                style: Primaryfont.ligh(16)
                    .copyWith(color: Colors.white, height: 1.8),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 60,
                width: 60,
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
                "Anxious",
                style: Primaryfont.ligh(16)
                    .copyWith(color: Colors.white, height: 1.8),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kColorDartPrimary,
                ),
                child: Image.asset('assets/images/ic_moon.png'),
              ),
              Text(
                "Sleep",
                style: Primaryfont.ligh(16)
                    .copyWith(color: Colors.white, height: 1.8),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kColorDartPrimary,
                ),
                child: Image.asset('assets/images/ic_kids.png'),
              ),
              Text(
                "Kids",
                style: Primaryfont.ligh(16)
                    .copyWith(color: Colors.white, height: 1.8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _titleSleep extends StatelessWidget {
  const _titleSleep();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Sleep Stories\n',
          style: Primaryfont.bold(24).copyWith(color: Colors.white),
          children: [
            TextSpan(
              text: 'Soothing bedtime stories to help you fall\n',
              style: Primaryfont.ligh(14)
                  .copyWith(color: Colors.white, height: 2.5),
              children: [
                TextSpan(
                  text: 'into a deep and natural sleep',
                  style: Primaryfont.ligh(14)
                      .copyWith(color: Colors.white, height: 1.2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
