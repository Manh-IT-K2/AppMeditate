import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/data/data_controller.dart';
import 'package:meditation_app/Common/message/dialog_message.dart';
import 'package:meditation_app/Common/screen/forget_password_textfield_screen.dart';
import 'package:meditation_app/Common/screen/otp_screen.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/detail_setting_page_widget/detail_setting_infomation_user/account_infor_screen.dart';
import 'package:meditation_app/Widgets/detail_setting_page_widget/detail_setting_infomation_user/widget_account_infor_screen/change_avata_user.dart';
import 'package:meditation_app/controller/editprofile_controller.dart';
import 'package:meditation_app/controller/forget_password_controller.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:meditation_app/controller/signin_controller.dart';
import 'package:meditation_app/controller/signup_controller.dart';

class BodyFormWidgetAccountInforMain extends StatefulWidget {
  const BodyFormWidgetAccountInforMain(
      {super.key,
      required this.fullName,
      required this.phone,
      required this.email,
      required this.image,
      required this.type});

  final TextEditingController fullName;
  final TextEditingController phone;
  final TextEditingController email;
  final String image;
  final bool type;

  @override
  State<BodyFormWidgetAccountInforMain> createState() =>
      _BodyFormWidgetAccountInforMainState();
}

class _BodyFormWidgetAccountInforMainState
    extends State<BodyFormWidgetAccountInforMain>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
  }

  @override
  void dispose() {
    _animationController
        .dispose(); // việc gọi dispose() sẽ dừng hoạt động của Ticker và giải phóng tài nguyên bên trong AnimationController, ngăn chặn rò rỉ tài nguyên và tiêu tốn bộ nhớ.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late Color color;
    final size = context.screenSize;
    final getPhone = Get.put(DataController());
    final controller = Get.put(ForgetPasswordController());
    final getIdUser = Get.put(EditProfileController());
    final statusLogin = Get.put(SignInController());
    final checkUsername = Get.put(SignUpController());
    final ValueNotifier<bool> validUsername = ValueNotifier<bool>(false);
    final ValueNotifier<bool> showError = ValueNotifier<bool>(false);
    String textError = "";
    final List<Icon> iconVerify = [
      const Icon(
        Icons.check_circle_outline,
        color: Colors.green,
      ),
      const Icon(
        Icons.error,
        color: Colors.red,
      ),
    ];
    return Column(
      children: [
        Stack(
          children: [
            FutureBuilder(
              future: getIdUser.getSavedColor(),
              builder: (BuildContext context, AsyncSnapshot<Color> snapshot) {
                color = snapshot.data ?? Colors.black;
                File imageFile = File(widget.image);
                return Container(
                  margin: const EdgeInsets.only(top: 50),
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: color, width: 2),
                      image: DecorationImage(
                          image: widget.type
                              ? Image.file(imageFile).image
                              : AssetImage(widget.image),
                          fit: BoxFit.contain)),
                );
              },
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
                child: InkWell(
                  onTap: () {
                    ChageAvataUser().BuildShowmodalBottomSheet(
                        context, color, widget.image);
                  },
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
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: statusLogin.getStringUsername(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                final String? username = snapshot.data;
                if (snapshot.hasData) {
                  return ValueListenableBuilder(
                    valueListenable: validUsername,
                    builder: (context, value, child) {
                      return Text(
                        username!,
                        style: Primaryfont.bold(20)
                            .copyWith(color: Colors.pink, height: 2),
                      );
                    },
                  );
                } else {
                  return Text(
                    translation(context).txtLoading,
                    style: Primaryfont.bold(16).copyWith(color: Colors.black),
                  );
                }
              },
            ),
            IconButton(
              onPressed: () async {
                final usersModel = await getIdUser.getUser();
                int statusChangeUser = usersModel!.statusChageUser;
                if (statusChangeUser == 1) {
                  // ignore: use_build_context_synchronously
                  DialogMessage.show(
                      context, translation(context).txtMessageChangeUserNameE);
                } else {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            translation(context).txtChangeUserName,
                            style: Primaryfont.bold(20)
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                      content: SizedBox(
                        height: 150,
                        child: Column(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: showError,
                              builder: (context, value, child) {
                                return ValueListenableBuilder(
                                  valueListenable: validUsername,
                                  builder: (context, value, child) {
                                    return TextField(
                                      cursorColor: Colors.black,
                                      controller: getIdUser.userName,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        suffix: validUsername.value
                                            ? iconVerify[0]
                                            : iconVerify[1],
                                      ),
                                      onChanged: (value) {
                                        textError = "";
                                        showError.value = false;
                                        RegExp regExp = RegExp(
                                            r'^(?=.*[A-Z])(?!.*[\s!@#$%^&*()\-=_+[\]{}|;:",.<>?`~]).{5,9}$');
                                        bool isValid = regExp.hasMatch(
                                            getIdUser.userName.text.trim());
                                        if (isValid) {
                                          validUsername.value = true;
                                        } else {
                                          validUsername.value = false;
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                            ValueListenableBuilder(
                              valueListenable: showError,
                              builder: (context, value, child) {
                                return showError.value
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          textError,
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
                            Text(
                              translation(context).txtMessageChangeUserNameS,
                              style: Primaryfont.medium(14)
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        // TextButton(
                        //   child: Text(
                        //     "Cancel",
                        //     style: Primaryfont.bold(16)
                        //         .copyWith(color: Colors.black),
                        //   ),
                        //   onPressed: () {
                        //     //Navigator.pop(context);
                        //   },
                        // ),
                        TextButton(
                          child: Text(
                            translation(context).txtOk,
                            style: Primaryfont.bold(16)
                                .copyWith(color: Colors.black),
                          ),
                          onPressed: () async {
                            final userName = getIdUser.userName.text.trim();
                            RegExp regExp = RegExp(
                                r'^(?=.*[A-Z])(?!.*[\s!@#$%^&*()\-=_+[\]{}|;:",.<>?`~]).{5,9}$');
                            bool isValid = regExp.hasMatch(userName);
                            if (userName == "") {
                              validUsername.value = false;
                              showError.value = true;
                              textError = translation(context).txtCheckEmpty;
                            } else if (!isValid) {
                              validUsername.value = false;
                              showError.value = true;
                              textError =
                                  translation(context).txtCheckUsernameInvalid;
                            } else {
                              final userId = usersModel.id ?? "";
                              if (await checkUsername.checkUserName(userName)) {
                                validUsername.value = false;
                                showError.value = true;
                                textError =
                                    translation(context).txtCheckUsernameExists;
                              } else {
                                validUsername.value = true;
                                // SaveChange.userName = userName;
                                statusLogin.saveUsername(userName);
                                getIdUser.updateUsername(userId, userName);
                                SizedBox(
                                  width: size.width,
                                  height: size.height,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: SpinKitFadingCircle(
                                        color: Colors.pink,
                                        size: 50.0,
                                        controller: _animationController),
                                  ),
                                );
                                Get.offAll(() => const AccountInfor());
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              icon: const Icon(
                Icons.create_outlined,
                size: 25,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        EditTextfieldWidget(
          label: translation(context).txtFullName,
          //prefix: const Icon(Icons.person),
          sWitdh: size.width,
          controller: widget.fullName,
          suffix: ButtonLinkWidget(
            func: () {},
            icon: Colors.transparent,
            text: Colors.transparent,
          ),
        ),
        EditTextfieldWidget(
          label: translation(context).txtPhone,
          //prefix: const Icon(Icons.phone),
          sWitdh: size.width,
          controller: widget.phone,
          suffix: ButtonLinkWidget(
            func: () {
              Get.to(() => ForgetPasswordTextfieldScreen(
                    lbTextField: translation(context).txtPhone,
                    iconData: Icons.phone,
                    controller: controller.phone,
                    assetImage: imgForgetPaswordPhoneBG,
                    title: translation(context).txtPhoneVerificationTitle,
                    subTitle: translation(context).txtPhoneVerificationSubTitle,
                    onPressedBT: () async {
                      final phoneNumber = controller.phone.text.trim();
                      RegExp phoneExp = RegExp(
                          r"^(?:\+84|0)(3[2-9]\d{8}|5\d{8}|7[0-9]\d{7}|8[1-9]\d{7}|9[0-1]\d{7}|9[4-9]\d{7})$");
                      String phone =
                          phoneNumber.replaceAll(RegExp(r'[()\s]+'), '');
                      bool checkPhone = await controller.checkPhone(phone);
                      bool isValid = phoneExp.hasMatch(phone);
                      final userModel = await getIdUser.getUser();
                      final userId = userModel!.id;
                      getPhone.setPhone(phoneNumber);
                      if (phoneNumber == "") {
                        // ignore: use_build_context_synchronously
                        DialogMessage.show(
                            context, translation(context).txtCheckEmpty);
                      } else if (!isValid) {
                        isIconValid.value = false;
                        // ignore: use_build_context_synchronously
                        DialogMessage.show(context,
                            translation(context).txtMessageCheckPhoneE);
                      } else if (checkPhone) {
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
                                      getIdUser.updatePhone(userId!, phone);
                                      Get.to(() => const AccountInfor());
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      DialogMessage.show(
                                        context,
                                        translation(context).txtMessageCheckOtp,
                                      );
                                    }
                                  },
                                ),
                            arguments: getPhone.phone.value);
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
          label: translation(context).tEmail,
          sWitdh: size.width,
          controller: widget.email,
          suffix: ButtonLinkWidget(
            func: () {
              Get.to(
                () => ForgetPasswordTextfieldScreen(
                  title: translation(context).tEmail,
                  subTitle: translation(context).txtEmailVerificationSubTitle,
                  lbTextField: translation(context).tEmail,
                  assetImage: imgForgetPaswordEmailBG,
                  controller: controller.email,
                  iconData: Icons.email,
                  onPressedBT: () async {
                    final email = controller.email.text.trim();
                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{3}$');
                    bool isvalid = emailRegex.hasMatch(email);
                    bool validEmail = await controller.checkEmail(email);
                    final userModel = await getIdUser.getUser();
                    final userId = userModel!.id;
                    if (email == "") {
                      // ignore: use_build_context_synchronously
                      DialogMessage.show(
                          context, translation(context).txtCheckEmpty);
                    } else if (!isvalid) {
                      // ignore: use_build_context_synchronously
                      DialogMessage.show(
                          context, translation(context).txtMessageCheckEmailE);
                    } else if (validEmail) {
                      // ignore: use_build_context_synchronously
                      DialogMessage.show(
                          context, translation(context).txtMessageCheckEmailE1);
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
                              getIdUser.updateEmail(userId!, email);
                              Get.to(() => const AccountInfor());
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
      width: 50,
      height: 60,
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
              translation(context).txtLink,
              style: Primaryfont.bold(10).copyWith(color: text),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class EditTextfieldWidget extends StatelessWidget {
  EditTextfieldWidget(
      {super.key,
      required this.label,
      required this.sWitdh,
      this.suffix,
      this.prefix,
      required this.controller});

  final String label;
  final double sWitdh;
  final Widget? suffix, prefix;
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
