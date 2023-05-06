import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/data/data_controller.dart';
import 'package:meditation_app/Common/message/dialog_message.dart';
import 'package:meditation_app/Common/screen/forget_password_textfield_screen.dart';
import 'package:meditation_app/Common/screen/otp_screen.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Constant/size.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/signin_page_widget/forget_password/forget_change_password.dart';
import 'package:meditation_app/Widgets/signin_page_widget/forget_password/forget_password_btn_widget.dart';
import 'package:meditation_app/controller/editprofile_controller.dart';
import 'package:meditation_app/controller/forget_password_controller.dart';
import 'package:meditation_app/controller/signup_controller.dart';

class ForgetPasswordScreen {
  static Future<dynamic> BuildShowmodalBottomSheet(BuildContext context) {
    final getData = Get.put(DataController());
    final controller = Get.put(ForgetPasswordController());
    final getPhoneUser = Get.put(ForgetPasswordController());
    final checkUsername = Get.put(SignUpController());
    final getUser = Get.put(EditProfileController());
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(tDefaulSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tForgetPasswordTitle,
              style: Primaryfont.bold(24).copyWith(height: 1.5),
            ),
            Text(
              tForgetPasswordSubTitle,
              style: Primaryfont.thin(14),
            ),
            const SizedBox(
              height: 20,
            ),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.email_outlined,
              title: tEmail,
              subTitle: tResetViaEMail,
              onTap: () {
                Get.to(
                  () => ForgetPasswordTextfieldScreen(
                    title: "Forgot your password?",
                    subTitle:
                        "Please enter the email you registered\n your account with to recover your password.",
                    lbTextField: "Email",
                    controller: controller.email,
                    assetImage: imgForgetPaswordEmailBG,
                    iconData: Icons.email,
                    onPressedBT: () async {
                      if (formKey.currentState!.validate()) {
                        final email = controller.email.text.trim();
                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{3}$');

                        bool isvalid = emailRegex.hasMatch(email);
                        bool validEmail = await controller.checkEmail(email);
                        if (email == "") {
                          // ignore: use_build_context_synchronously
                          DialogMessage.show(context, "Not be empty.");
                        } else if (!isvalid) {
                          // ignore: use_build_context_synchronously
                          DialogMessage.show(
                              context, "Invalid email ! try again.");
                        } else if (!validEmail) {
                          // ignore: use_build_context_synchronously
                          DialogMessage.show(context,
                              "Email has not been registered ! try again.");
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
                                  final usersModel =
                                      await controller.getUserWithEmail(email);
                                  Get.to(
                                    () => ForgetChangePassword(
                                        usersModel: usersModel),
                                  );
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
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{3}$');
                      final email = controller.email.text.trim();
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
            ),
            const SizedBox(
              height: 15.0,
            ),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.mobile_friendly_rounded,
              title: tPhoneNo,
              subTitle: tResetViaPhone,
              onTap: () {
                Get.to(
                  () => ForgetPasswordTextfieldScreen(
                    lbTextField: "Phone",
                    iconData: Icons.phone,
                    controller: controller.phone,
                    assetImage: imgForgetPaswordPhoneBG,
                    title: "Forgot your password?",
                    subTitle:
                        "Please enter the phone number you registered\n your account with to recover your password.",
                    onPressedBT: () async {
                      if (formKey.currentState!.validate()) {
                        final phone = controller.phone.text.trim();
                        String phoneNumber =
                            phone.replaceAll(RegExp(r'[()\s]+'), '');
                        bool isValid = await controller.checkPhone(phoneNumber);
                        getData.setPhone(phoneNumber);
                        if (phoneNumber == "") {
                          // ignore: use_build_context_synchronously
                          DialogMessage.show(context, "Not be empty.");
                        } else if (!isValid) {
                          isIconValid.value = false;
                          // ignore: use_build_context_synchronously
                          DialogMessage.show(
                              context, "Unregistered phone number! try again.");
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
                                        final userModel = await getPhoneUser
                                            .getUserWithPhone(phoneNumber);
                                        Get.to(
                                          () => ForgetChangePassword(
                                            usersModel: userModel,
                                          ),
                                          arguments: phoneNumber,
                                        );
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        DialogMessage.show(
                                          context,
                                          "Incorrect otp code please re-enter.",
                                        );
                                      }
                                    },
                                  ),
                              arguments: getData.phone.value);
                        }
                      }
                    },
                    onChangedTF: (value) async {
                      final phone = controller.phone.text.trim();
                      String phoneNumber =
                          phone.replaceAll(RegExp(r'[()\s]+'), '');
                      bool isValid = await controller.checkPhone(phoneNumber);
                      if (isValid) {
                        isIconValid.value = true;
                      } else {
                        isIconValid.value = false;
                      }
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.question_mark,
              title: "Other",
              subTitle:
                  "If your account has not verified\nEmail and Phone number",
              onTap: () {
                Get.to(
                  () => ForgetPasswordTextfieldScreen(
                    title: "Forgot your password?",
                    subTitle:
                        "Please enter the username with which you registered your account.",
                    lbTextField: "Username",
                    assetImage: imgForgetPaswordUserBG,
                    controller: controller.userName,
                    iconData: Icons.person,
                    onPressedBT: () async {
                      if (formKey.currentState!.validate()) {
                        final userName = controller.userName.text.trim();
                        bool checkUserName =
                            await checkUsername.checkUserName(userName);
                        getData.setUserName(userName);
                        if (userName == "") {
                          // ignore: use_build_context_synchronously
                          DialogMessage.show(context, "Not be empty.");
                        } else if (!checkUserName) {
                          isIconValid.value = false;
                          // ignore: use_build_context_synchronously
                          DialogMessage.show(
                              context, "Username is incorrect! Try again.");
                        } else {
                          isIconValid.value = true;
                          final userModel = await getUser.getUser(userName);
                          final exitsEmail = userModel.email;
                          final exitsPhone = userModel.phone;
                          if (exitsEmail != "" || exitsPhone != "") {
                            // ignore: use_build_context_synchronously
                            DialogMessage.show(context,
                                "This account has linked email or phone, please use the authentication method to retrieve the password.");
                          } else {
                            Get.to(
                                () =>
                                    ForgetChangePassword(usersModel: userModel),
                                arguments: getData.userName.value);
                          }
                        }
                      }
                    },
                    onChangedTF: (value) async {
                      final userName = controller.userName.text.trim();
                      bool user = await checkUsername.checkUserName(userName);
                      if (!user) {
                        isIconValid.value = false;
                      } else {
                        isIconValid.value = true;
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
