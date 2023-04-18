import 'package:flutter/material.dart';
import 'package:meditation_app/Utils/theme.dart';

class HeaderCircleWidget extends StatelessWidget {
  const HeaderCircleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Stack(
      children: [
        Positioned(
          top: 130,
          left: size.width / 2 - 84,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFF1ECBE9),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              Icons.star,
              color: Colors.yellow,
            ),
          ),
        ),
        Positioned(
          top: 125,
          left: size.width / 2 - 58,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1ECBE9),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              Icons.man,
              color: Colors.red,
            ),
          ),
        ),
        Positioned(
          top: 120,
          right: size.width / 2 - 24,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF1ECBE9),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              Icons.music_note,
              color: Colors.green,
            ),
          ),
        ),
        Positioned(
          top: 125,
          right: size.width / 2 - 58,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1ECBE9),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              Icons.mode_night,
              color: Colors.orange,
            ),
          ),
        ),
        Positioned(
          top: 130,
          right: size.width / 2 - 84,
          width: 30,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1ECBE9),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              Icons.water_drop,
              color: Colors.purple,
            ),
          ),
        ),
      ],
    );
  }
}
