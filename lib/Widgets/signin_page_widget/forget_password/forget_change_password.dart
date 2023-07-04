import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/sign_in_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/change_password_controller.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:meditation_app/controller/signup_controller.dart';
import 'package:meditation_app/model/users_model.dart';

class ForgetChangePassword extends StatelessWidget {
  const ForgetChangePassword({super.key, required this.usersModel});

 final UsersModel usersModel;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());
    final controllers = Get.put(SignUpController());
    final ValueNotifier<bool> showErrorNewPass = ValueNotifier<bool>(false);
    final ValueNotifier<bool> showErrorConfirmPass = ValueNotifier<bool>(false);
    final ValueNotifier<bool> isHidenNewPass = ValueNotifier<bool>(false);
    final ValueNotifier<bool> isHidenRePass = ValueNotifier<bool>(false);
    String newPasswordError = "";
    String confirmPassError = "";
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: AssetImage(imgChangePasswordBG)),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                 translation(context).txtChangePassword,
                  style: Primaryfont.bold(24)
                      .copyWith(color: Colors.black, height: 2),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  translation(context).txtTitleFogetPass,
                  textAlign: TextAlign.center,
                  style: Primaryfont.ligh(14)
                      .copyWith(color: Colors.grey, height: 1.5),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
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
                          text: Text(translation(context).txtNewPass),
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
                          onChange: (value) {
                            confirmPassError = translation(context).txtIncorrectPassword;
                            showErrorConfirmPass.value = false;
                          },
                          controller: controller.confirmPassword,
                          text: Text(translation(context).txtConfirmPass),
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
                      height: 50,
                    ),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final newPassword =
                                controller.newPassword.text.trim();
                            final confirmPassword =
                                controller.confirmPassword.text.trim();
                            final userId = usersModel.id;

                            // check String null
                            if (newPassword == "" || confirmPassword == "") {
                              Get.snackbar(translation(context).txtError,
                                  translation(context).txtSnackErrPass,
                                  icon: const Icon(Icons.error,
                                      color: Colors.white),
                                  snackPosition: SnackPosition.TOP,
                                  duration: const Duration(seconds: 5),
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                            } // check new password isvalid
                            else if (controllers.isPasswordValid(
                                    controller.newPassword.text.trim()) ==
                                false) {
                              showErrorNewPass.value = true;
                            }
                            // check password match or not
                            else if (newPassword != confirmPassword) {
                              showErrorConfirmPass.value = true;
                            } else {
                              controller.updatePassword(userId!, newPassword);
                              Get.to(() => const SignIn());
                              Get.snackbar(
                                  translation(context).txtSuccess, translation(context).txtSnackSuccessUpdatePass,
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
                         translation(context).txtSaveChange,
                          style: Primaryfont.bold(14)
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
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
  final Text text;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      controller: controller,
      cursorColor: Colors.black,
      obscureText: !isHidenPass.value,
      decoration: InputDecoration(
        label: text,
        labelStyle: const TextStyle(color: Colors.black),
        prefixIcon: const Icon(Icons.lock, color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            width: 1.0,
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            width: 1.0,
            color: Colors.grey,
          ),
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
