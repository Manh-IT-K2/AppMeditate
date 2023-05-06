import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/forget_password_controller.dart';

final formKey = GlobalKey<FormState>();
final ValueNotifier<bool> isIconValid = ValueNotifier<bool>(false);

class ForgetPasswordTextfieldScreen extends StatelessWidget {
  const ForgetPasswordTextfieldScreen({
    super.key,
    required this.title,
    required this.subTitle,
    required this.lbTextField,
    required this.assetImage,
    required this.controller,
    required this.iconData,
    required this.onPressedBT,
    required this.onChangedTF,
  });
  final String title, subTitle,assetImage, lbTextField;
  final IconData iconData;
  final Function()? onPressedBT;
  final Function(String)? onChangedTF;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    final getUser = Get.put(ForgetPasswordController());

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
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // if (SaveChangeBack.page == 0) {
                      //   Get.off(() => const SignIn());
                      // } else {
                      //   Get.off(() => const AccountInfor());
                      // }
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Back",
                    style: Primaryfont.bold(14).copyWith(color: Colors.black),
                  ),
                ],
              ),
              Image(
                image: AssetImage(assetImage),
                height: 400,
                fit: BoxFit.cover,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Primaryfont.bold(24).copyWith(color: Colors.black),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: Primaryfont.ligh(14)
                    .copyWith(color: Colors.black, height: 1.5),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: isIconValid,
                      builder: (context, value, child) {
                        return TextField(
                          controller: controller,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            label: Text(
                              lbTextField,
                              style: Primaryfont.medium(14)
                                  .copyWith(color: Colors.black),
                            ),
                            prefixIcon: Icon(
                              iconData,
                              size: 30,
                              color: Colors.black,
                            ),
                            fillColor: Colors.white,
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
                            suffix: isIconValid.value
                                ? iconVerify[0]
                                : iconVerify[1],
                          ),
                          onChanged: onChangedTF,
                        );
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 30),
                      height: 70,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: onPressedBT,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shadowColor: Colors.pink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          "Next",
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

class SaveChangeBack {
  static int page = 0;
}
