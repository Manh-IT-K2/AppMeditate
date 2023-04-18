import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/image_string.dart';

class CustomSnackBarWidget extends StatelessWidget {
  const CustomSnackBarWidget({
    super.key,
    required this.sizeWidth,
    required this.title,
    required this.subTitle,
  });

  final double sizeWidth;
  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            imgChatbotError,
            height: 80,
            width: 80,
          ),
        ),
        Container(
          height: 120,
          width: sizeWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.red,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
