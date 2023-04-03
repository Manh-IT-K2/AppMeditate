import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Utils/theme.dart';

class HeaderDetailSettingWidget extends StatelessWidget {
  const HeaderDetailSettingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('$ContainerPage');
                SaveChange.indexPage = 4;
              },
              hoverColor: Colors.transparent,
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 25,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              txtSetting,
              style: Primaryfont.bold(14).copyWith(color: Colors.black),
            ),
          ],
        ),
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                border: Border.all(color: Colors.pink, width: 2),
                image: const DecorationImage(
                    image: AssetImage('assets/images/bg_favorite.jpeg'),
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 60, left: 40),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kColorPrimary,
                  border: Border.all(color: Colors.white, width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/ic_camera.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Text(
          'Quan Manh',
          style: Primaryfont.bold(20).copyWith(color: Colors.pink, height: 1.5),
        ),
      ],
    );
  }
}
