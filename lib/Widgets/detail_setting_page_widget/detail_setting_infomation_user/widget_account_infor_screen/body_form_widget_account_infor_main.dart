import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Utils/theme.dart';

class BodyFormWidgetAccountInforMain extends StatelessWidget {
  const BodyFormWidgetAccountInforMain({
    super.key,
    required this.fullName,
    required this.phone,
    required this.email,
  });

  final TextEditingController fullName;
  final TextEditingController phone;
  final TextEditingController email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
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
              margin: const EdgeInsets.only(top: 100, left: 40),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kColorPrimary,
                  border: Border.all(color: Colors.white, width: 1.8)),
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
          SaveChange.userName,
          style: Primaryfont.bold(20).copyWith(color: Colors.pink, height: 2),
        ),
        const SizedBox(
          height: 50,
        ),
        EditTextfieldWidget(
          label: "FullName",
          //data: user.fullName,
          controller: fullName,
        ),
        EditTextfieldWidget(
          label: "Phone",
          //data: user.phone,
          controller: phone,
        ),
        EditTextfieldWidget(
          label: "Email",
          //data: user.email,
          controller: email,
        ),
      ],
    );
  }
}

class EditTextfieldWidget extends StatelessWidget {
  EditTextfieldWidget(
      {super.key,
      required this.label,
      //required this.data,
      required this.controller});

  final String label;
  //var data;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Container(
      width: size.width,
      height: 80.0,
      padding: const EdgeInsets.only(bottom: 20),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
          blurRadius: 30,
          offset: const Offset(1, 1),
          color: Colors.pink.withOpacity(0.2),
        ),
      ]),
      child: TextFormField(
        controller: controller,
        //initialValue: data,
        cursorColor: Colors.pink,
        decoration: InputDecoration(
          labelText: label,
          fillColor: Colors.white,
          filled: true,
          labelStyle: const TextStyle(color: Colors.pink, fontSize: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
