import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Pages/signup_or_singin_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActionDetailSettingWidget extends StatelessWidget {
  const ActionDetailSettingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isSwith1 =
        ValueNotifier<bool>(SaveChange.changeSwitch[0]);
    final ValueNotifier<bool> isSwith2 =
        ValueNotifier<bool>(SaveChange.changeSwitch[1]);
    return Container(
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            padding: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.language,
                      color: Colors.black,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      txtDetailSettingAction1,
                      style:
                          Primaryfont.medium(14).copyWith(color: Colors.black),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.grey,
                  size: 25,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            padding: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.cell_tower,
                      color: Colors.black,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      txtDetailSettingAction2,
                      style:
                          Primaryfont.medium(14).copyWith(color: Colors.black),
                    ),
                  ],
                ),
                ValueListenableBuilder(
                  valueListenable: isSwith1,
                  builder: (context, value, child) {
                    return Switch(
                      value: isSwith1.value,
                      activeColor: Colors.red,
                      onChanged: (bool value) {
                        isSwith1.value = value;
                        SaveChange.changeSwitch[0] = isSwith1.value;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            padding: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.do_not_disturb,
                      color: Colors.black,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      txtDetailSettingAction3,
                      style:
                          Primaryfont.medium(14).copyWith(color: Colors.black),
                    ),
                  ],
                ),
                ValueListenableBuilder(
                  valueListenable: isSwith2,
                  builder: (context, value, child) {
                    return Switch(
                      value: isSwith2.value,
                      activeColor: Colors.red,
                      onChanged: (bool value) {
                        isSwith2.value = value;
                        SaveChange.changeSwitch[1] = isSwith2.value;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Colors.black,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      txtDetailSettingAction4,
                      style:
                          Primaryfont.medium(14).copyWith(color: Colors.black),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove('isLoggedIn');
                    prefs.remove('Username');
                    Get.offAll(() => const SingupOrSignin());
                  },
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.grey,
                    size: 25,
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
