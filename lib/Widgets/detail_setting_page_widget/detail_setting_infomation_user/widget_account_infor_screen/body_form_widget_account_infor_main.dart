import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/data/data_controller.dart';
import 'package:meditation_app/Common/message/dialog_message.dart';
import 'package:meditation_app/Common/screen/forget_password_textfield_screen.dart';
import 'package:meditation_app/Common/screen/otp_screen.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/detail_setting_page_widget/detail_setting_infomation_user/account_infor_screen.dart';
import 'package:meditation_app/controller/editprofile_controller.dart';
import 'package:meditation_app/controller/forget_password_controller.dart';

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
    final size = context.screenSize;
    final getPhone = Get.put(DataController());
    final controller = Get.put(ForgetPasswordController());
    final getIdUser = Get.put(EditProfileController());
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
          //prefix: const Icon(Icons.person),
          sWitdh: size.width,
          controller: fullName,
          suffix: ButtonLinkWidget(
            func: () {},
            icon: Colors.transparent,
            text: Colors.transparent,
          ),
        ),
        EditTextfieldWidget(
          label: "Phone",
          //prefix: const Icon(Icons.phone),
          onChanged: (value) {
            TFChange.onchange = 1;
          },
          sWitdh: size.width,
          controller: phone,
          suffix: ButtonLinkWidget(
            func: () {
              Get.to(() => ForgetPasswordTextfieldScreen(
                    lbTextField: "Phone",
                    iconData: Icons.phone,
                    controller: controller.phone,
                    assetImage: imgForgetPaswordPhoneBG,
                    title: "Phone number verification !",
                    subTitle:
                        "Please enter the phone number you are using, please do not\n use a virtual phone number",
                    onPressedBT: () async {
                      if (formKey.currentState!.validate()) {
                        final phoneNumber = controller.phone.text.trim();
                        RegExp phoneExp = RegExp(
                            r"^(?:\+84|0)(3[2-9]\d{8}|5\d{8}|7[0-9]\d{7}|8[1-9]\d{7}|9[0-1]\d{7}|9[4-9]\d{7})$");
                        String phone =
                            phoneNumber.replaceAll(RegExp(r'[()\s]+'), '');
                        bool checkPhone = await controller.checkPhone(phone);
                        bool isValid = phoneExp.hasMatch(phone);
                        final userModel = await getIdUser.getUser("Qm");
                        final userId = userModel.id;
                        getPhone.setPhone(phoneNumber);
                        if (phoneNumber == "") {
                          // ignore: use_build_context_synchronously
                          DialogMessage.show(context, "Not be empty.");
                        } else if (!isValid) {
                          isIconValid.value = false;
                          // ignore: use_build_context_synchronously
                          DialogMessage.show(context,
                              "The phone number you entered is invalid or exists! try again.");
                        } else if (checkPhone) {
                          // ignore: use_build_context_synchronously
                          DialogMessage.show(
                              context, "Registered phone number.");
                        } else {
                          controller.phoneAuthentication(phoneNumber);
                          Get.to(
                              () => OTPScreen(
                                    text: controller.phone.text.trim(),
                                    onPressed: () async {
                                      if (otp == null) {
                                        // ignore: use_build_context_synchronously
                                        DialogMessage.show(
                                          context,
                                          "Your please enter the code OTP.",
                                        );
                                      } else if (await controller
                                          .verifyOTP(otp)) {
                                        getIdUser.updatePhone(userId!, phone);
                                        Get.to(() => const AccountInfor());
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        DialogMessage.show(
                                          context,
                                          "Incorrect otp code please re-enter.",
                                        );
                                      }
                                    },
                                  ),
                              arguments: getPhone.phone.value);
                        }
                      }
                    },
                    onChangedTF: (value) {
                      final phoneNumber = controller.phone.text.trim();
                      RegExp phoneExp = RegExp(
                          r"^(?:\+84|0)(3[2-9]\d{8}|5\d{8}|7[0-9]\d{7}|8[1-9]\d{7}|9[0-1]\d{7}|9[4-9]\d{7})$");
                      String phone =
                          phoneNumber.replaceAll(RegExp(r'[()\s]+'), '');
                      bool isValid = phoneExp.hasMatch(phone);
                      if (isValid) {
                        isIconValid.value = true;
                      } else {
                        isIconValid.value = false;
                      }
                    },
                  ));
            },
            icon: Colors.pink,
            text: Colors.black,
          ),
        ),
        EditTextfieldWidget(
          label: "Email",
          //prefix: const Icon(Icons.email),
          onChanged: (value) {
            TFChange.onchange = 2;
          },
          sWitdh: size.width,
          controller: email,
          suffix: ButtonLinkWidget(
            func: () {
              Get.to(
                () => ForgetPasswordTextfieldScreen(
                  title: "Email",
                  subTitle: "Please enter the email you are using, do not enter\n a virtual email !",
                  lbTextField: "Email",
                  assetImage: imgForgetPaswordEmailBG,
                  controller: controller.email,
                  iconData: Icons.email,
                  onPressedBT: () async {
                    if (formKey.currentState!.validate()) {
                      final email = controller.email.text.trim();
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{3}$');
                      bool isvalid = emailRegex.hasMatch(email);
                      bool validEmail = await controller.checkEmail(email);
                      final userModel = await getIdUser.getUser("Qm");
                      final userId = userModel.id;
                      if (email == "") {
                        // ignore: use_build_context_synchronously
                        DialogMessage.show(
                            context, "Not be empty ! try again.");
                      } else if (!isvalid) {
                        // ignore: use_build_context_synchronously
                        DialogMessage.show(
                            context, "Invalid email ! try again.");
                      } else if (validEmail) {
                        // ignore: use_build_context_synchronously
                        DialogMessage.show(context,
                            "Email has been posted linked to another account ! Try again.");
                      } else {
                        Random random = Random();
                        int otpEmail = random.nextInt(900000) + 100000;
                        String otps = otpEmail.toString();
                        controller.sendOtpEmail(email, otpEmail.toString());
                        Get.to(
                          () => OTPScreen(
                            text: email,
                            onPressed: () async {
                              if (otp == null) {
                                DialogMessage.show(
                                  context,
                                  "Your please enter the code OTP.",
                                );
                              } else if (otp == otps) {
                                getIdUser.updateEmail(userId!, email);
                                Get.to(() => const AccountInfor());
                              } else {
                                // ignore: use_build_context_synchronously
                                DialogMessage.show(
                                  context,
                                  "Incorrect otp code please re-enter.",
                                );
                              }
                            },
                          ),
                        );
                      }
                    }
                  },
                  onChangedTF: (value) {
                    final email = controller.email.text.trim();
                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{3}$');
                    bool isvalid = emailRegex.hasMatch(email);
                    if (isvalid) {
                      isIconValid.value = true;
                    } else {
                      isIconValid.value = false;
                    }
                  },
                ),
              );
            },
            icon: Colors.pink,
            text: Colors.black,
          ),
        ),
      ],
    );
  }
}

class ButtonLinkWidget extends StatelessWidget {
  const ButtonLinkWidget({super.key, this.func, this.icon, this.text});
  final Function()? func;
  final Color? icon, text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 50,
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: func,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.link_off_outlined,
              color: icon,
              size: 20,
            ),
            Text(
              "Link",
              style: Primaryfont.bold(10).copyWith(color: text),
            ),
          ],
        ),
      ),
    );
  }
}

class EditTextfieldWidget extends StatelessWidget {
  EditTextfieldWidget(
      {super.key,
      required this.label,
      required this.sWitdh,
      this.suffix,
      this.prefix,
      this.onChanged,
      required this.controller});

  final String label;
  final double sWitdh;
  final Widget? suffix, prefix;
  void Function(String)? onChanged;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sWitdh,
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
        onChanged: onChanged,
        controller: controller,
        cursorColor: Colors.pink,
        decoration: InputDecoration(
          labelText: label,
          fillColor: Colors.white,
          filled: true,
          prefix: prefix,
          contentPadding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
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
          suffix: suffix,
        ),
      ),
    );
  }
}

class TFChange {
  static int onchange = 0;
}
