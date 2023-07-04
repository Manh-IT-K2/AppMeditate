import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/data/data_controller.dart';
import 'package:meditation_app/Common/message/dialog_message.dart';
import 'package:meditation_app/Common/screen/forget_password_textfield_screen.dart';
import 'package:meditation_app/Common/screen/otp_screen.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Constant/size.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/signin_page_widget/forget_password/forget_change_password.dart';
import 'package:meditation_app/Widgets/signin_page_widget/forget_password/forget_password_btn_widget.dart';
import 'package:meditation_app/controller/editprofile_controller.dart';
import 'package:meditation_app/controller/forget_password_controller.dart';
import 'package:meditation_app/controller/language_controller.dart';
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
              translation(context).tForgetPasswordTitle,
              style: Primaryfont.bold(24).copyWith(height: 1.5),
            ),
            Text(
              translation(context).tForgetPasswordSubTitle,
              style: Primaryfont.thin(14),
            ),
            const SizedBox(
              height: 20,
            ),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.email_outlined,
              title: translation(context).tEmail,
              subTitle: translation(context).tResetViaEMail,
              onTap: () {
                Get.to(
                  () => ForgetPasswordTextfieldScreen(
                    title: translation(context).txtForgotPass,
                    subTitle: translation(context).txtForgotPassEmailSubTitle,
                    lbTextField: translation(context).tEmail,
                    controller: controller.email,
                    assetImage: imgForgetPaswordEmailBG,
                    iconData: Icons.email,
                    onPressedBT: () async {
                      final email = controller.email.text.trim();
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{3}$');

                      bool isvalid = emailRegex.hasMatch(email);
                      bool validEmail = await controller.checkEmail(email);
                      if (email == "") {
                        // ignore: use_build_context_synchronously
                        DialogMessage.show(
                            context, translation(context).txtCheckEmpty);
                      } else if (!isvalid) {
                        // ignore: use_build_context_synchronously
                        DialogMessage.show(context,
                            translation(context).txtMessageCheckEmailE);
                      } else if (!validEmail) {
                        // ignore: use_build_context_synchronously
                        DialogMessage.show(context,
                            translation(context).txtMessageCheckEmailE1);
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
                                  translation(context).txtMessageEnterOtp,
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
                                  translation(context).txtMessageCheckOtp,
                                );
                              }
                            },
                          ),
                        );
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
              title: translation(context).tPhoneNo,
              subTitle: translation(context).tResetViaPhone,
              onTap: () {
                Get.to(
                  () => ForgetPasswordTextfieldScreen(
                    lbTextField: translation(context).txtPhone,
                    iconData: Icons.phone,
                    controller: controller.phone,
                    assetImage: imgForgetPaswordPhoneBG,
                    title: translation(context).txtForgotPass,
                    subTitle: translation(context).txtForgotPassPhoneSubTitle,
                    onPressedBT: () async {
                      final phone = controller.phone.text.trim();
                      String phoneNumber =
                          phone.replaceAll(RegExp(r'[()\s]+'), '');
                      bool isValid = await controller.checkPhone(phoneNumber);
                      getData.setPhone(phoneNumber);
                      if (phoneNumber == "") {
                        // ignore: use_build_context_synchronously
                        DialogMessage.show(
                            context, translation(context).txtCheckEmpty);
                      } else if (!isValid) {
                        isIconValid.value = false;
                        // ignore: use_build_context_synchronously
                        DialogMessage.show(context,
                            translation(context).txtMessageCheckPhoneE1);
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
                                        translation(context).txtMessageEnterOtp,
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
                                        translation(context).txtMessageCheckOtp,
                                      );
                                    }
                                  },
                                ),
                            arguments: getData.phone.value);
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
              title: translation(context).txtOther,
              subTitle: translation(context).txtOtherSubTitle,
              onTap: () {
                Get.to(
                  () => ForgetPasswordTextfieldScreen(
                    title: translation(context).txtForgotPass,
                    subTitle:
                        translation(context).txtForgotPassUsernameSubTitle,
                    lbTextField: translation(context).txtUsername,
                    assetImage: imgForgetPaswordUserBG,
                    controller: controller.userName,
                    iconData: Icons.person,
                    onPressedBT: () async {
                      final userName = controller.userName.text.trim();
                      bool checkUserName =
                          await checkUsername.checkUserName(userName);
                      getData.setUserName(userName);
                      if (userName == "") {
                        // ignore: use_build_context_synchronously
                        DialogMessage.show(
                            context, translation(context).txtCheckEmpty);
                      } else if (!checkUserName) {
                        isIconValid.value = false;
                        // ignore: use_build_context_synchronously
                        DialogMessage.show(context,
                            translation(context).txtCheckUsernameIncorrect);
                      } else {
                        isIconValid.value = true;
                        final userModel = await getUser.getUserr(userName);
                        final exitsEmail = userModel.email;
                        final exitsPhone = userModel.phone;
                        if (exitsEmail != "" || exitsPhone != "") {
                          // ignore: use_build_context_synchronously
                          DialogMessage.show(context,
                              translation(context).txtCheckUsernameLinked);
                        } else {
                          Get.to(
                              () => ForgetChangePassword(usersModel: userModel),
                              arguments: getData.userName.value);
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
