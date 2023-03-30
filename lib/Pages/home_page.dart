import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Pages/course_details_page.dart';
import 'package:meditation_app/Utils/theme.dart';

class CardItem {
  final String image;
  final String title;
  final String subtitle;

  const CardItem(
      {required this.image, required this.title, required this.subtitle});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    List<CardItem> items = [
      const CardItem(
          image: 'assets/images/bg_foucus.png',
          title: 'Focus',
          subtitle: 'MEDITATION • 3-10 MIN'),
      const CardItem(
          image: 'assets/images/bg_hepiness.png',
          title: 'Happiness',
          subtitle: 'MEDITATION • 3-10 MIN'),
      const CardItem(
          image: 'assets/images/bg_foucus.png',
          title: 'Focus',
          subtitle: 'MEDITATION • 3-10 MIN'),
      const CardItem(
          image: 'assets/images/bg_hepiness.png',
          title: 'Happiness',
          subtitle: 'MEDITATION • 3-10 MIN'),
      const CardItem(
          image: 'assets/images/bg_foucus.png',
          title: 'Focus',
          subtitle: 'MEDITATION • 3-10 MIN'),
      const CardItem(
          image: 'assets/images/bg_hepiness.png',
          title: 'Happiness',
          subtitle: 'MEDITATION • 3-10 MIN'),
      const CardItem(
          image: 'assets/images/bg_foucus.png',
          title: 'Focus',
          subtitle: 'MEDITATION • 3-10 MIN'),
      const CardItem(
          image: 'assets/images/bg_hepiness.png',
          title: 'Happiness',
          subtitle: 'MEDITATION • 3-10 MIN'),
      const CardItem(
          image: 'assets/images/bg_foucus.png',
          title: 'Focus',
          subtitle: 'MEDITATION • 3-10 MIN'),
      const CardItem(
          image: 'assets/images/bg_hepiness.png',
          title: 'Happiness',
          subtitle: 'MEDITATION • 3-10 MIN'),
      const CardItem(
          image: 'assets/images/bg_foucus.png',
          title: 'Focus',
          subtitle: 'MEDITATION • 3-10 MIN'),
      const CardItem(
          image: 'assets/images/bg_hepiness.png',
          title: 'Happiness',
          subtitle: 'MEDITATION • 3-10 MIN'),
    ];
    return Scaffold(
      backgroundColor: kColorLightGrey,
      body: SafeArea(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset('assets/images/ic_logoBlack.svg'),
            ),
            Align(
              alignment: const Alignment(-0.70, 0.0),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  text: 'Good Morning, Afsar\n',
                  style: Primaryfont.bold(24).copyWith(
                    color: Colors.black,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(
                      text: 'We Wish you have a good day',
                      style: Primaryfont.medium(14)
                          .copyWith(color: kColorDartPrimary),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF8E97FD),
                  ),
                  width: size.width * 0.45,
                  height: size.height * 0.25,
                  // color: Color(0xFF8E97FD),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                          ),
                          child: Image.asset(
                            'assets/images/bg_basic.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(-0.80, 0.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'Basics\n',
                            style: Primaryfont.bold(20).copyWith(
                              color: kColorLightYellow,
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(
                                text: 'COURSE',
                                style: Primaryfont.bold(10)
                                    .copyWith(color: kColorLightYellow),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 20),
                        child: Row(
                          children: [
                            Text(
                              '3-10 MIN',
                              style: Primaryfont.medium(12)
                                  .copyWith(color: kColorLightGrey),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            MaterialButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  SaveChange.indexPage = 2;
                                  return const CourseDetails();
                                }));
                              },
                              color: Colors.white,
                              height: 40,
                              minWidth: 54,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(38),
                              ),
                              child: Text(
                                'START',
                                style: Primaryfont.ligh(12)
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFFFDB9D),
                  ),
                  width: size.width * 0.45,
                  height: size.height * 0.25,
                  // color: Color(0xFFFFDB9D),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/bg_relexation.png',
                              fit: BoxFit.cover,
                            ),
                          )),
                      Align(
                        alignment: const Alignment(-0.70, 0.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Relexation\n',
                              style: Primaryfont.bold(20)
                                  .copyWith(color: Colors.black, height: 1.5),
                              children: [
                                TextSpan(
                                  text: 'MUSIC',
                                  style: Primaryfont.bold(10)
                                      .copyWith(color: Colors.black),
                                )
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 20),
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text(
                              '3-10 MIN',
                              style: Primaryfont.medium(12)
                                  .copyWith(color: Colors.black),
                            ),
                            const SizedBox(
                              width: 28,
                            ),
                            MaterialButton(
                              onPressed: () {},
                              minWidth: 54,
                              height: 40,
                              color: const Color(0xFF263238),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(38),
                              ),
                              child: Text('START',
                                  style: Primaryfont.ligh(12).copyWith(
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: 93,
              width: 373,
              margin: const EdgeInsets.only(top: 30, left: 12, right: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF333242),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/bg_dailythounght.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: const Alignment(0.2, 0.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Daily Thought\n',
                              style: Primaryfont.bold(20)
                                  .copyWith(color: Colors.white, height: 2),
                              children: [
                                TextSpan(
                                    text: 'MEDITATION',
                                    style: Primaryfont.ligh(12)
                                        .copyWith(color: Colors.white),
                                    children: [
                                      TextSpan(
                                        text: ' • 3-10 MIN',
                                        style: Primaryfont.ligh(12)
                                            .copyWith(color: Colors.white),
                                      )
                                    ])
                              ]),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: const Alignment(0.7, 0.0),
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/images/bg_play.png'),
                          iconSize: 40,
                        ),
                      ),
                    )
                  ],
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0, left: 12.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Recomended for you',
                style: Primaryfont.bold(24).copyWith(color: Colors.black),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 12, right: 12),
              height: 200,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      buildCard(item: items[index]),
                  separatorBuilder: (context, _) => const SizedBox(
                        width: 10,
                      ),
                  itemCount: 12),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildCard({
  required CardItem item,
}) =>
    SizedBox(
      width: 180,
      //height: 180,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Material(
                  child: Ink.image(
                    image: AssetImage(item.image),
                    fit: BoxFit.cover,
                    child: InkWell(onTap: () {}
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => SleepPage(),)),
                        ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: const Alignment(-0.9, 0.0),
            child: Text(
              item.title,
              style: Primaryfont.medium(14).copyWith(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: const Alignment(-0.9, 0.0),
            child: Text(
              item.subtitle,
              style: Primaryfont.ligh(10).copyWith(color: kColorDartPrimary),
            ),
          ),
        ],
      ),
    );
