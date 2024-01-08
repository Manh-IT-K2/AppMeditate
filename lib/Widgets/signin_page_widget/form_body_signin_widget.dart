import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/data/data_controller.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/get_started_page.dart';
import 'package:meditation_app/Pages/sign_up_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/signin_page_widget/forget_password/forget_password_screen.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:meditation_app/controller/signin_controller.dart';

// ignore: camel_case_types, must_be_immutable
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
    //final saveColorBoderAvt = Get.put(EditProfileController());
    final userNameControlller = Get.put(DataController());
    final saveLoginSatus = Get.put(SignInController());
    //final formKey = GlobalKey<FormState>();
    return SizedBox(
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
                hintText: translation(context).txtUsername,
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
                    hintText: translation(context).txtPassword,
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
              //if (formKey.currentState!.validate()) {
                final userName = controller.userName.text.trim();
                final passWord = controller.passWord.text.trim();
                bool isValid = await controller.logIn(userName, passWord);
                if (userName == "" || passWord == "") {
                  // final snackBar = SnackBar(
                  //   content: CustomSnackBarWidget(
                  //     sizeWidth: sizee.width,
                  //     title: 'Error !',
                  //     subTitle:
                  //         'You have not entered the complete information?',
                  //   ),
                  //   backgroundColor: Colors.transparent,
                  //   elevation: 0,
                  //   behavior: SnackBarBehavior.floating,
                  //   duration: const Duration(seconds: 2),
                  Get.snackbar(translation(context).txtError,
                     translation(context).txtSnackErrLogin,
                      icon: const Icon(Icons.error, color: Colors.white),
                      snackPosition: SnackPosition.TOP,
                      duration: const Duration(seconds: 3),
                      backgroundColor: Colors.red,
                      colorText: Colors.white);
    
                  //ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (isValid) {
                  controller.saveUsername(userName);
                  final String username =
                      await controller.getStringUsername();
                  userNameControlller.setUserName(username);
                  //save satus login
                  saveLoginSatus.saveLoginStatus();
                  // save color boder avt
                  //saveColorBoderAvt.saveColor(Colors.black);
                  Get.off(() => const GetstartedPage(),
                      arguments: userNameControlller.userName.value);
                  Get.snackbar(translation(context).txtSuccess, translation(context).txtSnackSuccessLogged,
                      icon: const Icon(Icons.check_circle,
                          color: Color.fromARGB(255, 3, 64, 5)),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green.withOpacity(0.6),
                      colorText: const Color.fromARGB(255, 16, 87, 18));
                } else {
                  Get.snackbar(translation(context).txtError, translation(context).txtSnackErrLoginCheck,
                      icon: const Icon(Icons.error, color: Colors.white),
                      snackPosition: SnackPosition.TOP,
                      duration: const Duration(seconds: 3),
                      backgroundColor: Colors.red,
                      colorText: Colors.white);
                }
              //}
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
              translation(context).txtSignIn,
              style: Primaryfont.medium(14).copyWith(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextButton(
              onPressed: () {
                ForgetPasswordScreen.BuildShowmodalBottomSheet(context);
              },
              child: Text(
                translation(context).txtForgotPassword,
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
                  translation(context).txtHeaderSignup,
                  style: Primaryfont.medium(14)
                      .copyWith(color: kColorDartPrimary),
                ),
                TextButton(
                  onPressed: () {
                    // Navigator.of(context).pushNamed('/SignUp');
                    Get.off(() => const SignUp());
                  },
                  child: Text(
                    translation(context).txtSignUp,
                    style:
                        Primaryfont.medium(12).copyWith(color: kColorPrimary),
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
