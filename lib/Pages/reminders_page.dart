import 'package:flutter/material.dart';
import 'package:meditation_app/Common/widget/reponsive_builder.dart';
import 'package:meditation_app/Widgets/reminder_page_widget/reminder_day_select_widget.dart';
import 'package:meditation_app/Widgets/reminder_page_widget/reminder_footer_widget.dart';
import 'package:meditation_app/Widgets/reminder_page_widget/reminder_time_select_widget.dart';
import 'package:meditation_app/Widgets/reminder_page_widget/reminder_title_widget.dart';
import 'package:meditation_app/controller/language_controller.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ReponsiveBuilder(
          portrait: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, //
            children: [
              const Spacer(),
              Expanded(
                flex: 2,
                child: ReminderTitleWidget(
                  title: translation(context).txtReminderTitle1,
                  subtitle: translation(context).txtReminderSubTitle1,
                ),
              ),
              const Expanded(
                flex: 3,
                child: ReminderTimeSelectsWidget(),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 2,
                child: ReminderTitleWidget(
                  title: translation(context).txtReminderTitle2,
                  subtitle: translation(context).txtReminderSubTitle2,
                ),
              ),
              const Expanded(
                child: ReminderDaySelectsWidget(),
              ),
              const Expanded(
                flex: 2,
                child: ReminderFooterWidget(),
              ),
            ],
          ),
          landscape: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30, left: 30),
                        child: ReminderTitleWidget(
                          title: translation(context).txtReminderTitle1,
                          subtitle: translation(context).txtReminderSubTitle1,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 30, right: 30, bottom: 30),
                        child: ReminderTimeSelectsWidget(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ReminderTitleWidget(
                          title: translation(context).txtReminderTitle2,
                          subtitle: translation(context).txtReminderSubTitle2,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: ReminderDaySelectsWidget(),
                    ),
                    const Expanded(
                      flex: 2,
                      child: ReminderFooterWidget(),
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
