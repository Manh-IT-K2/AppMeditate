import 'package:flutter/material.dart';
import 'package:meditation_app/Common/widget/neubox_widget.dart';
import 'package:meditation_app/Pages/detail_music_page.dart';

class BodyDetailMusicWidget extends StatelessWidget {
  const BodyDetailMusicWidget({
    super.key,
    required this.widget,
  });

  final DetailMusic widget;

  @override
  Widget build(BuildContext context) {
    return NeuBox(
      child: Column(
        children: [
          SizedBox(
            height: 330,
            width: 350,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                widget.image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    widget.nameSong,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.favorite_border,
                  size: 25,
                  color:
                      DarkMode.darkLight.value ? Colors.black : Colors.pink,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
