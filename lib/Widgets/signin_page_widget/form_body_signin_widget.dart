import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Pages/get_started_page.dart';
import 'package:meditation_app/Pages/sign_up_page.dart';
import 'package:meditation_app/Utils/theme.dart';

class form_body_signin_widget extends StatelessWidget {
  form_body_signin_widget({
    super.key,
    required this.a,
    required this.size,
    required this.sHeight,
    required this.sWidth,
    required this.sHeightTF,
    required this.sWidthTF,
    this.sFooter,
  });

  final MaterialStateProperty<Size> size;
  final ValueNotifier<bool> a;
  final double sHeight, sWidth, sHeightTF, sWidthTF;
  late double? sFooter;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      width: sWidth,
      height: sHeight,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            width: sWidthTF,
            height: sHeightTF,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(1, 1),
                  color: Colors.grey.withOpacity(0.1),
                ),
              ],
            ),
            child: TextField(
              //controller: _userTextController,
              decoration: InputDecoration(
                prefixIcon: Image.asset(imgUser),
                fillColor: const Color(0xFFF2F3F7),
                filled: true,
                hintText: txtUsername,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: sWidthTF,
            height: sHeightTF,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(1, 1),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ]),
            child: ValueListenableBuilder(
              valueListenable: a,
              builder: (context, value, child) {
                return TextField(
                  //controller: _passwordTextController,
                  obscureText: !value,
                  decoration: InputDecoration(
                    prefixIcon: Image.asset(imgLock),
                    fillColor: const Color(0xFFF2F3F7),
                    filled: true,
                    hintText: txtPassword,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                    ),
                    suffix: GestureDetector(
                      onTap: () {
                        a.value = !a.value;
                      },
                      child: Icon(
                        a.value ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: sFooter,
          ),
          ElevatedButton(
            onPressed: () {
              //signIn();
              Navigator.of(context).pushNamed('$GetstartedPage');
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kColorPrimary),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(38),
                ),
              ),
              elevation: MaterialStateProperty.all(0),
              fixedSize: size,
            ),
            child: Text(
              txtSignIn,
              style: Primaryfont.medium(14).copyWith(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextButton(
              onPressed: () {},
              child: Text(
                txtForgotPassword,
                style: Primaryfont.medium(14).copyWith(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FittedBox(
            child: Row(
              children: [
                Text(
                  txtAlreadyAccount,
                  style:
                      Primaryfont.medium(14).copyWith(color: kColorDartPrimary),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('$SignUp');
                  },
                  child: Text(
                    txtSignUp,
                    style:
                        Primaryfont.medium(14).copyWith(color: kColorPrimary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
