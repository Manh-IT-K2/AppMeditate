import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';

class CardItem {
  final String image;
  final String title;
  final String subtitle;

  const CardItem(
      {required this.image, required this.title, required this.subtitle});
}
 
class FooterHomeWidget extends StatelessWidget {
  const FooterHomeWidget({
    super.key,
    required this.imgHeight,
    required this.imgWidth,
    required this.sTextHeader,
    required this.sTextSubTitle,
    required this.sTextTitle,
    required this.sbWidth,
    required this.sContainerHeight,
  });
  final double sbWidth, imgWidth, imgHeight, sTextHeader,sTextTitle, sTextSubTitle, sContainerHeight;
  @override
  Widget build(BuildContext context) {
    List<CardItem> items = [
      CardItem(
          image: imgHomeBGFoucus,
          title: 'Focus',
          subtitle: txtCaditemHomeSubTitle),
      CardItem(
          image: imgHomeBHepiness,
          title: 'Happiness',
          subtitle: txtCaditemHomeSubTitle),
      CardItem(
          image: imgHomeBGFoucus,
          title: 'Focus',
          subtitle: txtCaditemHomeSubTitle),
      CardItem(
          image: imgHomeBHepiness,
          title: 'Happiness',
          subtitle: txtCaditemHomeSubTitle),
      CardItem(
          image: imgHomeBGFoucus,
          title: 'Focus',
          subtitle: txtCaditemHomeSubTitle),
      CardItem(
          image: imgHomeBHepiness,
          title: 'Happiness',
          subtitle: txtCaditemHomeSubTitle),
      CardItem(
          image: imgHomeBGFoucus,
          title: 'Focus',
          subtitle: txtCaditemHomeSubTitle),
      CardItem(
          image: imgHomeBHepiness,
          title: 'Happiness',
          subtitle: txtCaditemHomeSubTitle),
      CardItem(
          image: imgHomeBGFoucus,
          title: 'Focus',
          subtitle: txtCaditemHomeSubTitle),
      CardItem(
          image: imgHomeBHepiness,
          title: 'Happiness',
          subtitle: txtCaditemHomeSubTitle),
      CardItem(
          image: imgHomeBGFoucus,
          title: 'Focus',
          subtitle: txtCaditemHomeSubTitle),
      CardItem(
          image: imgHomeBHepiness,
          title: 'Happiness',
          subtitle: txtCaditemHomeSubTitle),
    ];
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20.0, left: 12.0),
          alignment: Alignment.centerLeft,
          child: Text(
            'Recomended for you',
            style: Primaryfont.bold(sTextHeader).copyWith(color: Colors.black),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20,bottom:20,left: 12, right: 12),
          height: sContainerHeight,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => buildCard(
                item: items[index], 
                sbWidth: sbWidth,
                sTextTitle: sTextTitle,
                sTextSubTitle: sTextSubTitle,
                imgHeight: imgHeight,
                imgWidth: imgWidth
                ),
              separatorBuilder: (context, _) => const SizedBox(
                    width: 10,
                  ),
              itemCount: 12),
        ),
      ],
    );
  }
}

Widget buildCard({
  required CardItem item,
  required double sTextTitle, sTextSubTitle,sbWidth,imgWidth, imgHeight,
}) =>
    SizedBox(
      width: sbWidth,
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
                    width: imgWidth,
                    height: imgHeight,
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
              style: Primaryfont.medium(sTextTitle).copyWith(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: const Alignment(-0.9, 0.0),
            child: Text(
              item.subtitle,
              style: Primaryfont.ligh(sTextSubTitle).copyWith(color: kColorDartPrimary),
            ),
          ),
        ],
      ),
    );
