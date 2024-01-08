import 'package:flutter/material.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Pages/reminders_page.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/Widgets/reminder_page_widget/reminder_footer_widget.dart';

class ReminderTimeSelectsWidget extends StatelessWidget {
  const ReminderTimeSelectsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // hours wheel
            SizedBox(
              width: 50,
              child: ListWheelScrollView.useDelegate(
                onSelectedItemChanged: (value) => SaveChange.hour = "$value",
                itemExtent: 50,
                perspective: 0.005,
                diameterRatio: 1.2,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: 13,
                  builder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        index.toString(),
                        style:
                            Primaryfont.bold(24).copyWith(color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
            ),

            // minutes wheel
            SizedBox(
              width: 50,
              child: ListWheelScrollView.useDelegate(
                onSelectedItemChanged: (value) => SaveChange.minute = "$value",
                itemExtent: 50,
                perspective: 0.005,
                diameterRatio: 1.2,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: 60,
                  builder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        index < 10 ? '0$index' : index.toString(),
                        style:
                            Primaryfont.bold(24).copyWith(color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
            ),
            // AM or PM
            SizedBox(
              width: 50,
              child: ListWheelScrollView.useDelegate(
                onSelectedItemChanged: (value) => SaveChange.timeFormat = "$value",
                itemExtent: 50,
                perspective: 0.005,
                diameterRatio: 1.2,
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: 2,
                  builder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        index == 0 ? 'AM' : 'PM',
                        style:
                            Primaryfont.bold(24).copyWith(color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
