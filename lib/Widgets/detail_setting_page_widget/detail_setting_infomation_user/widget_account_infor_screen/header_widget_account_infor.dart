import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Common/message/dialog_message.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Pages/detail_setting_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/detail_setting_page_widget/detail_setting_infomation_user/account_infor_screen.dart';
import 'package:meditation_app/Widgets/detail_setting_page_widget/detail_setting_infomation_user/widget_account_infor_screen/body_form_widget_account_infor_main.dart';
import 'package:meditation_app/model/users_model.dart';

class HeaderWidgetAccountInfor extends StatelessWidget {
  const HeaderWidgetAccountInfor({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.id,
    required this.user,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.day,
    required this.month,
    required this.year,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final String? id;
  final UsersModel user;
  final TextEditingController fullName;
  final TextEditingController email;
  final TextEditingController phone;
  final ValueNotifier<String> gender;
  final TextEditingController day;
  final TextEditingController month;
  final TextEditingController year;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
                onTap: () {
                  Get.off(() => const DetailSettingUser());
                },
                child: const Icon(Icons.arrow_back_ios, size: 30)),
            const SizedBox(
              width: 10,
            ),
            Text(
              txtEditProfile,
              style: Primaryfont.medium(16),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if(TFChange.onchange == 1 || TFChange.onchange == 2){
                DialogMessage.show(context, "Not enter you must link");
              }else{
                final users = UsersModel(
                  id: id,
                  userName: user.userName,
                  passWord: user.passWord,
                  fullName: fullName.text.trim(),
                  email: email.text.trim(),
                  phone: phone.text.trim(),
                  gender: gender.value,
                  joinDay: user.joinDay,
                  birtDay:
                      "${day.text.trim()} / ${month.text.trim()} / ${year.text.trim()}");

              await controller.updateUser(users, id!);
              Get.snackbar("Success!", "Information has been updated.",
                  icon: const Icon(Icons.error, color: Colors.white),
                  snackPosition: SnackPosition.TOP,
                  duration: const Duration(seconds: 3),
                  backgroundColor: Colors.green,
                  colorText: Colors.white);
              }
              
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shadowColor: Colors.pink,
              //elevation: 3, // độ bóng của nút
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(
            "Lưu",
            style: Primaryfont.bold(16).copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
