import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/size.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/signin_page_widget/forget_password/forget_password_btn_widget.dart';

class ForgetPasswordScreen {
  static Future<dynamic> BuildShowmodalBottomSheet(BuildContext context) {
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
              height: 30,
            ),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.email_outlined,
              title: tEmail,
              subTitle: tResetViaEMail,
              onTap: () {
               
                },
            ),
            const SizedBox(
              height: 20.0,
            ),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.mobile_friendly_rounded,
              title: tPhoneNo,
              subTitle: tResetViaPhone,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
