import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/widget/snackbar_widget.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Pages/get_started_page.dart';
import 'package:meditation_app/Pages/sign_up_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/signin_controller.dart';

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
    final controller = Get.put(SignInController());
    final formKey = GlobalKey<FormState>();
    final sizee = context.screenSize;
    return Form(
      key: formKey,
      child: Container(
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
                controller: controller.userName,
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
                    controller: controller.passWord,
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
              onPressed: () async {
                //signIn();
                if (formKey.currentState!.validate()) {
                  final userName = controller.userName.text.trim();
                  final passWord = controller.passWord.text.trim();

                  bool isValid = await controller.LogIn(userName, passWord);
                  if (userName == "" || passWord == "") {
                    final snackBar = SnackBar(
                      content: CustomSnackBarWidget(
                        sizeWidth: sizee.width,
                        title: 'Error !',
                        subTitle:
                            'You have not entered the complete information?',
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (isValid) {                                     
                    Get.off(() => const GetstartedPage());
                    Get.snackbar("Success !", "Logged in successfully.",
                        icon: const Icon(Icons.check_circle, color: Color.fromARGB(255, 3, 64, 5)),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green.withOpacity(0.6),
                        colorText: const Color.fromARGB(255, 16, 87, 18));
                  } else {
                    final snackBar = SnackBar(
                      content: CustomSnackBarWidget(
                        sizeWidth: sizee.width,
                        title: 'Error !',
                        subTitle: 'Ussername or Password wrong !',
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
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
                    style: Primaryfont.medium(14)
                        .copyWith(color: kColorDartPrimary),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigator.of(context).pushNamed('/SignUp');
                      Get.off(() => const SignUp());
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
      ),
    );
  }
}
