import 'package:flutter/material.dart';
import 'package:meditation_app/Pages/detail_music_favorite_page.dart';

class NeuBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final child;
  const NeuBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      // ignore: sort_child_properties_last
      child: child,
      decoration: BoxDecoration(
        color:
            DarkMode.darkLight.value ? Colors.grey[850] : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // right bottom
          BoxShadow(
            color: DarkMode.darkLight.value
                ? Colors.grey.shade900
                : Colors.grey.shade500,
            blurRadius: 15,
            offset: const Offset(5, 5),
          ),
          //top left
          BoxShadow(
            color: DarkMode.darkLight.value
                ? Colors.grey.shade800
                : Colors.white,
            blurRadius: 15,
            offset: const Offset(-5, -5),
          ),
        ],
      ),
    );
  }
}
