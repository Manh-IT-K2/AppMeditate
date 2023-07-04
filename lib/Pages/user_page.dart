import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Widgets/user_page_widget/appbar_user_widget.dart';
import 'package:meditation_app/Widgets/user_page_widget/chart_user_widget.dart';
import 'package:meditation_app/Widgets/user_page_widget/function_user_widget.dart';
import 'package:meditation_app/Widgets/user_page_widget/overview_user_widget.dart';

class UserAfsarPage extends StatelessWidget {
  const UserAfsarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorLightGrey,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: const SingleChildScrollView(
            child: Column(
              children: [
                AppBarUserWidget(),
                ChartUserWidget(),
                OverviewUserWidget(),
                FunctionUserWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
