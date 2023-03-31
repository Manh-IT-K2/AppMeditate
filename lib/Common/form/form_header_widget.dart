import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Pages/signup_or_singin_page.dart';
import 'package:meditation_app/Utils/theme.dart';

// ignore: camel_case_types
class form_header_widget extends StatelessWidget {
  const form_header_widget({
    super.key,
    required this.size,
    required this.sHeight,
    required this.sWidth,
  });

  final Size size;
  final double sHeight, sWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      width: sWidth,
      height: sHeight,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('$SingupOrSignin');
              },
              icon: Image.asset(imgBack),
              hoverColor: const Color.fromARGB(255, 241, 241, 241),
              iconSize: 50,
            ),
          ),
          Text(
            txtHeaderSignup,
            style: Primaryfont.bold(24),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Image.asset(
             imgFacebook,
              alignment: Alignment.centerLeft,
            ),
            label: Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Text(
                    txtWithFacebook,
                    style: Primaryfont.medium(14).copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                backgroundColor: const Color(0xFF7583CA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(38),
                ),
                fixedSize: size),
          ),
          const SizedBox(
            height: 20,
          ),
          Flexible(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Image.asset(imgGoogle),
              label: Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Text(
                      txtWithGoogle,
                      style:
                          Primaryfont.medium(14).copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(38),
                  ),
                  fixedSize: size),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
           txtwithEmail,
            style: Primaryfont.medium(14).copyWith(
              color: const Color(0xFFA1A4B2),
            ),
          ),
        ],
      ),
    );
  }
}
