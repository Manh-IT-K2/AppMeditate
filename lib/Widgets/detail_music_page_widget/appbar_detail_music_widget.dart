import 'package:flutter/material.dart';
import 'package:meditation_app/Common/widget/neubox_widget.dart';
import 'package:meditation_app/Pages/course_details_page.dart';
import 'package:meditation_app/Pages/detail_music_favorite_page.dart';

class AppBarDetailMusicFavoriteWidget extends StatelessWidget {
  const AppBarDetailMusicFavoriteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: NeuBox(
              child: InkWell(
                onTap: () {
                  DarkMode.play.stop();
                  Navigator.of(context).pushNamed('$CourseDetails');
                },
                child: const Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
          ),
          Text(
            'CHILL',
            style: TextStyle(
              color: DarkMode.darkLight.value ? Colors.black : Colors.pink,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'HelveticaNeue',
            ),
          ),
          SizedBox(
            width: 50,
            height: 50,
            child: NeuBox(
              child: InkWell(
                onTap: () {
                  DarkMode.darkLight.value = !DarkMode.darkLight.value;
                },
                child: Icon(DarkMode.darkLight.value
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
