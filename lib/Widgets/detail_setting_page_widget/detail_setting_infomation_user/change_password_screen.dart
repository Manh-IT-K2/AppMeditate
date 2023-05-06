import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Pages/sign_in_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/signin_page_widget/forget_password/forget_password_screen.dart';
import 'package:meditation_app/controller/change_password_controller.dart';
import 'package:meditation_app/controller/editprofile_controller.dart';
import 'package:meditation_app/controller/signup_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());
    final controllers = Get.put(SignUpController());
    final getIdUser = Get.put(EditProfileController());
    final ValueNotifier<bool> showErrorNewPass = ValueNotifier<bool>(false);
    final ValueNotifier<bool> showErrorOldPass = ValueNotifier<bool>(false);
    final ValueNotifier<bool> showErrorConfirmPass = ValueNotifier<bool>(false);
    final ValueNotifier<bool> isHidenPass = ValueNotifier<bool>(false);
    final ValueNotifier<bool> isHidenNewPass = ValueNotifier<bool>(false);
    final ValueNotifier<bool> isHidenRePass = ValueNotifier<bool>(false);
    final size = context.screenSize;
    String newPasswordError = "";
    String oldPasswordError = "";
    String confirmPassError = "";
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                   Get.back();
                  },
                  icon: const Icon(Icons.arrow_back,
                      size: 30, color: Colors.black),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Back",
                  style: Primaryfont.bold(14).copyWith(color: Colors.black),
                ),
              ],
            ),
            Image(image: AssetImage(imgChangePasswordBG)),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Changes Password",
                style: Primaryfont.bold(24).copyWith(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: isHidenPass,
                      builder: (context, value, child) {
                        return inputTextField(
                          onChange: (value) {
                            oldPasswordError = "Incorrect password";
                            showErrorOldPass.value = false;
                          },
                          controller: controller.oldPassword,
                          text: "Password",
                          isHidenPass: isHidenPass,
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: showErrorOldPass,
                      builder: (context, value, child) {
                        return showErrorOldPass.value
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  oldPasswordError,
                                  style: Primaryfont.bold(12)
                                      .copyWith(color: Colors.red),
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ValueListenableBuilder(
                      valueListenable: isHidenNewPass,
                      builder: (context, value, child) {
                        return inputTextField(
                          onChange: (value) {
                            newPasswordError = controllers.validatePassword(
                                controller.newPassword.text.trim());
                            showErrorNewPass.value = false;
                          },
                          controller: controller.newPassword,
                          text: "New Password",
                          isHidenPass: isHidenNewPass,
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: showErrorNewPass,
                      builder: (context, value, child) {
                        return showErrorNewPass.value
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  newPasswordError,
                                  style: Primaryfont.bold(12)
                                      .copyWith(color: Colors.red),
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ValueListenableBuilder(
                      valueListenable: isHidenRePass,
                      builder: (context, value, child) {
                        return inputTextField(
                          onChange: (p0) {
                            confirmPassError = "Password incorrect";
                            showErrorConfirmPass.value = false;
                          },
                          controller: controller.confirmPassword,
                          text: "Confirm Password",
                          isHidenPass: isHidenRePass,
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: showErrorConfirmPass,
                      builder: (context, value, child) {
                        return showErrorConfirmPass.value
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  confirmPassError,
                                  style: Primaryfont.bold(12)
                                      .copyWith(color: Colors.red),
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                     alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                         ForgetPasswordScreen.BuildShowmodalBottomSheet(context);
                        },
                        child: Text(
                          txtForgotPassword,
                          style: Primaryfont.medium(14)
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      width: size.width,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final oldPAssword =
                                controller.oldPassword.text.trim();
                            final newPassword =
                                controller.newPassword.text.trim();
                            final confirmPassword =
                                controller.confirmPassword.text.trim();
                            final userModel = await getIdUser.getUser(SaveChange.userName);
                            final userId = userModel.id;
                            bool isCheckPass = await controller.checkPassword(
                                SaveChange.userName, oldPAssword);
                            // check String null
                            if (oldPAssword == "" ||
                                newPassword == "" ||
                                confirmPassword == "") {
                              Get.snackbar("Error!",
                                  "You have not entered the complete information?.",
                                  icon: const Icon(Icons.error,
                                      color: Colors.white),
                                  snackPosition: SnackPosition.TOP,
                                  duration: const Duration(seconds: 5),
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                            } // check old password
                            else if (!isCheckPass) {
                              showErrorOldPass.value = true;
                            } // check new password isvalid
                            else if (controllers.isPasswordValid(
                                    controller.newPassword.text.trim()) ==
                                false) {
                              showErrorNewPass.value = true;
                            } else if (newPassword == oldPAssword) {
                              newPasswordError =
                                  "Please set a different password than the old password";
                              showErrorNewPass.value = true;
                            }
                            // check password match or not
                            else if (newPassword != confirmPassword) {
                              showErrorConfirmPass.value = true;
                            } else {
                              controller.updatePassword(userId!, newPassword);
                              Get.off(() => Container());
                              SaveChange.indexPage = 4;
                              Get.snackbar(
                                  "Success!", "Password update successful.",
                                  icon: const Icon(Icons.error,
                                      color: Colors.white),
                                  snackPosition: SnackPosition.TOP,
                                  duration: const Duration(seconds: 5),
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shadowColor: Colors.pink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "Save Change",
                          style: Primaryfont.bold(14)
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class inputTextField extends StatelessWidget {
  inputTextField(
      {super.key,
      required this.isHidenPass,
      required this.text,
      required this.controller,
      this.onChange});

  final ValueNotifier<bool> isHidenPass;
  TextEditingController controller;
  Function(String)? onChange;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      controller: controller,
      cursorColor: Colors.black,
      obscureText: !isHidenPass.value,
      decoration: InputDecoration(
        hintText: text,
        prefixIcon: const Icon(Icons.lock, color: Colors.black),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        suffix: InkWell(
          onTap: () {
            isHidenPass.value = !isHidenPass.value;
          },
          child: Icon(
            isHidenPass.value ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
    );
  }
}
