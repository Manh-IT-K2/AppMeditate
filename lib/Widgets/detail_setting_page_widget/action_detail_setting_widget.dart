import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Pages/signup_or_singin_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/detail_setting_page_widget/detail_setting_action/change_language_screen.dart';
import 'package:meditation_app/controller/editprofile_controller.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActionDetailSettingWidget extends StatefulWidget {
  const ActionDetailSettingWidget({
    super.key,
  });

  @override
  State<ActionDetailSettingWidget> createState() =>
      _ActionDetailSettingWidgetState();
}

class _ActionDetailSettingWidgetState extends State<ActionDetailSettingWidget> {
  @override
  Widget build(BuildContext context) {
    bool isRefreshing = false; // Track if a refresh is in progress
    bool isRefreshing1 = false;
    final ValueNotifier<bool> isSwith1 =
        ValueNotifier<bool>(SaveChange.changeSwitch[0]);
    final ValueNotifier<bool> isSwith2 =
        ValueNotifier<bool>(SaveChange.changeSwitch[1]);
    final userController = Get.put(EditProfileController());
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
                      translation(context).txtDetailSettingAction1,
                      style:
                          Primaryfont.medium(14).copyWith(color: Colors.black),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const ChangeLanguageScreen());
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
                      translation(context).txtDetailSettingAction2,
                      style:
                          Primaryfont.medium(14).copyWith(color: Colors.black),
                    ),
                  ],
                ),
                FutureBuilder<bool>(
                  future: userController.getDowloadCellular(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      bool isCheck = snapshot.data!;
                      isSwith1.value = isCheck;
                      return ValueListenableBuilder(
                        valueListenable: isSwith1,
                        builder: (context, value, child) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              if (!isRefreshing) {
                                setState(() {
                                  isRefreshing =
                                      true; // Set the flag to prevent multiple refreshes
                                });
                                // await userController
                                //     .updateDowloadCellular(!isCheck);
                                setState(() {
                                  isRefreshing =
                                      false; // Reset the flag after refresh is done
                                });
                              }
                            },
                            child: Switch(
                              value: isSwith1.value,
                              activeColor: Colors.red,
                              onChanged: (bool value) async {
                                if (isCheck == true) {
                                  await userController
                                      .updateDowloadCellular(false);
                                } else {
                                  await userController
                                      .updateDowloadCellular(true);
                                }
                                isSwith1.value = value;
                                // Trigger a refresh manually
                                if (!isRefreshing) {
                                  setState(() {
                                    isRefreshing = true;
                                  });
                                  // await Future.delayed(
                                  //     const Duration(microseconds: 1)); //   
                                  setState(() {
                                    isRefreshing = false;
                                  });
                                }
                              },
                            ),
                          );
                        },
                      );
                    }
                    return const Text("");
                  },
                )
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
                      translation(context).txtDetailSettingAction3,
                      style:
                          Primaryfont.medium(14).copyWith(color: Colors.black),
                    ),
                  ],
                ),
                FutureBuilder<bool>(
                  future: userController.getDoNotDisturb(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      bool isCheck = snapshot.data!;
                      isSwith2.value = isCheck;
                      return ValueListenableBuilder(
                        valueListenable: isSwith2,
                        builder: (context, value, child) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              if (!isRefreshing1) {
                                setState(() {
                                  isRefreshing1 =
                                      true; // Set the flag to prevent multiple refreshes
                                });
                                // await userController
                                //     .updateDowloadCellular(!isCheck);
                                setState(() {
                                  isRefreshing1 =
                                      false; // Reset the flag after refresh is done
                                });
                              }
                            },
                            child: Switch(
                              value: isSwith2.value,
                              activeColor: Colors.red,
                              onChanged: (bool value) async {
                                if (isCheck == true) {
                                  await userController
                                      .updateDoNotDisturb(false);
                                } else {
                                  await userController
                                      .updateDoNotDisturb(true);
                                }
                                isSwith2.value = value;
                                // Trigger a refresh manually
                                if (!isRefreshing1) {
                                  setState(() {
                                    isRefreshing1 = true;
                                  });
                                  // await Future.delayed(
                                  //     const Duration(microseconds: 1)); //   
                                  setState(() {
                                    isRefreshing1 = false;
                                  });
                                }
                              },
                            ),
                          );
                        },
                      );
                    }
                    return const Text("");
                  },
                )
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
                      translation(context).txtDetailSettingAction4,
                      style:
                          Primaryfont.medium(14).copyWith(color: Colors.black),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
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
