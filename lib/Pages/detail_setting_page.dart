import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Widgets/detail_setting_page_widget/action_detail_setting_widget.dart';
import 'package:meditation_app/Widgets/detail_setting_page_widget/header_detail_setting_widget.dart';
import 'package:meditation_app/Widgets/detail_setting_page_widget/infomation_user_detail_setting_widget.dart';
import 'package:meditation_app/Widgets/detail_setting_page_widget/notification_detail_setting_widget.dart';
import 'package:meditation_app/Common/widget/reponsive_builder.dart';

class DetailSettingUser extends StatelessWidget {
  const DetailSettingUser({super.key});

  @override
  Widget build(BuildContext context) {
    //final size = context.screenSize;
    return Scaffold(
      backgroundColor: kColorLightGrey,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            child: ReponsiveBuilder(
              portrait: Column(
                children: const [
                  HeaderDetailSettingWidget(),
                  InfomationUserDetailSettingWidget(),
                  NotificationDetailSettingWidget(),
                  ActionDetailSettingWidget(),
                ],
              ),
              landscape: Column(
                children: const [
                  HeaderDetailSettingWidget(),
                  InfomationUserDetailSettingWidget(),
                  NotificationDetailSettingWidget(),
                  ActionDetailSettingWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
