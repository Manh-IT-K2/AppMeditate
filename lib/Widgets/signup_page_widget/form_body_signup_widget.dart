import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Pages/sign_in_page.dart';
import 'package:meditation_app/Utils/theme.dart';

// ignore: camel_case_types, must_be_immutable
class form_body_signup_widget extends StatelessWidget {
  form_body_signup_widget({
    super.key,
    required this.a,
    required this.isCheckbox,
    required this.size,
    required this.sHeight,
    required this.sWidth,
    required this.sHeightTF,
    required this.sWidthTF,
    this.sFooter,
  });

  final MaterialStateProperty<Size> size;
  final ValueNotifier<bool> a;
  final ValueNotifier<bool> isCheckbox;
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
            margin: const EdgeInsets.only(left: 20, right: 20),
            height: sHeightTF,
            width: sWidthTF,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(1, 1),
                  color: Colors.grey.withOpacity(0.1),
                )
              ],
            ),
            child: TextField(
              //controller: _userTextController,
              decoration: InputDecoration(
                prefixIcon: Image.asset(imgUser),
                fillColor: const Color(0xFFF2F3F7),
                filled: true,
                hintText: txtUsername,
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(1, 1),
                    color: Colors.grey.withOpacity(0.1),
                  )
                ]),
            child: SizedBox(
              height: sHeightTF,
              width: sWidthTF,
              // xây dựng lại widget mỗi khi biến a thay đổi
              child: ValueListenableBuilder(
                valueListenable: a,
                builder: (BuildContext context, bool value, Widget? child) {
                  return TextField(
                    //controller: _passwordTextController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !value,
                    decoration: InputDecoration(
                      prefixIcon: Image.asset(imgLock),
                      fillColor: const Color(0xFFF2F3F7),
                      filled: true,
                      hintText: txtPassword,
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1.0),
                      ),
                      suffix:
                          //Image.asset('assets/images/ic_hide.png'),
                          GestureDetector(
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
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(1, 1),
                  color: Colors.grey.withOpacity(0.1),
                )
              ],
            ),
            child: SizedBox(
              height: sHeightTF,
              width: sWidthTF,
              child: ValueListenableBuilder(
                valueListenable: a,
                builder: (BuildContext context, bool value, Widget? child) {
                  return TextField(
                    //controller: _repasswordTextController,
                    obscureText: !a.value,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      prefixIcon: Image.asset(imgLock),
                      fillColor: const Color(0xFFF2F3F7),
                      filled: true,
                      hintText: txtRePassword,
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1.0),
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
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20),
            child: FittedBox(
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: txtHaveRead,
                      style: Primaryfont.medium(14).copyWith(
                        color: kColorDartPrimary,
                      ),
                      children: [
                        TextSpan(
                          text: txtPrivacePolicy,
                          style: Primaryfont.medium(14)
                              .copyWith(color: kColorPrimary, height: 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  ValueListenableBuilder(
                    valueListenable: isCheckbox,
                    builder: (context, value, child) {
                      return Checkbox(
                        value: isCheckbox.value,
                        onChanged: (bool? value) {
                          isCheckbox.value = !isCheckbox.value;
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: sFooter,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('$SignIn');
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
              txtSignUp,
              style: Primaryfont.bold(14).copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
