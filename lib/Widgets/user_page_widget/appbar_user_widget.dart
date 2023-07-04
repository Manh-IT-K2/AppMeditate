import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Constant/image_string.dart';
import 'package:meditation_app/Pages/detail_setting_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/editprofile_controller.dart';
import 'package:meditation_app/controller/language_controller.dart';
import 'package:meditation_app/model/users_model.dart';

class AppBarUserWidget extends StatelessWidget {
  const AppBarUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final contronller = Get.put(EditProfileController());
    return FutureBuilder<UsersModel?>(
      future: contronller.getUser(),
      builder: ( context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data;
          final userName = user!.userName;
          bool type = user.typeImage;
          String image = user.image ?? avtDefault;
          File imageFile = File(image);
          return Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                   FutureBuilder(
                    future: contronller.getSavedColor(),
                    builder: (BuildContext context, AsyncSnapshot<Color> snapshot) {
                    Color color = snapshot.data ?? Colors.black;
                     return  Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: color, width: 2),
                        image: DecorationImage(
                          image: type? Image.file(imageFile).image : AssetImage(image),
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                   },),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      userName,
                      style: Primaryfont.bold(16).copyWith(color: Colors.black),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    // Navigator.of(context).pushNamed("$DetailSettingUser");
                    Get.to(() => const DetailSettingUser());
                  },
                  //borderRadius: BorderRadius.circular(20),
                  hoverColor: Colors.transparent,
                  child: const Icon(
                    Icons.settings_suggest_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text(
            translation(context).txtLoading,
            style: Primaryfont.bold(16).copyWith(color: Colors.black),
          );
        }
      },
    );
  }
}
