import 'package:flutter/material.dart';
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
      ],
    );
  }
}
