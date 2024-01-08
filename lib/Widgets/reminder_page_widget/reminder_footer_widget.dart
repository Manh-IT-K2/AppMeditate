
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/editprofile_controller.dart';
import 'package:meditation_app/controller/language_controller.dart';

class ReminderFooterWidget extends StatelessWidget {
  const ReminderFooterWidget({
    super.key,
   
  });

  @override
  Widget build(BuildContext context) {
    final userName = Get.arguments;
    final userController = Get.put(EditProfileController());
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: MaterialButton(
              onPressed: () async {
                if(SaveChange.timeFormat == "0"){
                  SaveChange.timeFormat = "AM";
                }else{
                  SaveChange.timeFormat = "PM";
                }
                if(SaveChange.day == "MO"){
                  SaveChange.day = "Mon";
                }else if(SaveChange.day == "TU"){
                  SaveChange.day = "Tue";
                }else if(SaveChange.day == "WE"){
                  SaveChange.day = "Wed";
                }else if(SaveChange.day == "TH"){
                  SaveChange.day = "Thu";
                }else if(SaveChange.day == "FR"){
                  SaveChange.day = "Fri";
                }else if(SaveChange.day == "SA"){
                  SaveChange.day = "Sat";
                }else{
                  SaveChange.day = "Sun";
                }
                await userController.updateReminderTime("${SaveChange.day} ${SaveChange.hour}:${SaveChange.minute} ${SaveChange.timeFormat}");
                Get.off(() => const ContainerPage(), arguments: userName);
              },
              textColor: Colors.white,
              color: kColorPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(38),
              ),
              child: Text(
                txtSave,
                style: Primaryfont.medium(14),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                Get.off(() => const ContainerPage(), arguments: userName);
              },
              child: Text(
                translation(context).txtNothank,
                style: Primaryfont.medium(14).copyWith(color: kColorDartGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}