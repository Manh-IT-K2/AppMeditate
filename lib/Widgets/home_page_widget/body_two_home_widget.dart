import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Utils/theme.dart';

class BodyHomeWidgetTwo extends StatelessWidget {
  const BodyHomeWidgetTwo({
    super.key,
    required this.sHeight,
    required this.sWidth,
  });

  final double sHeight, sWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sHeight,
      width: sWidth,
      margin: const EdgeInsets.only(top: 30, left: 12, right: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF333242),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imgHomeBGDailythounght,
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: const Alignment(0.7, 0.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(imgHomeICPlay),
                    iconSize: 40,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
