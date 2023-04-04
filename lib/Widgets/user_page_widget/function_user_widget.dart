import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';

class FunctionUserWidget extends StatelessWidget {
  const FunctionUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: kColorPrimary),
                      child: const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      txtUserFunction1,
                      style: Primaryfont.bold(14).copyWith(color: Colors.black),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.grey,
                  size: 25,
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      txtUserFunction2,
                      style: Primaryfont.bold(14).copyWith(color: Colors.black),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.grey,
                  size: 25,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.download,
                      color: Colors.black,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      txtUserFunction3,
                      style: Primaryfont.bold(14).copyWith(color: Colors.black),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.grey,
                  size: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}