import 'package:flutter/material.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Widgets/reminder_page_widget/reminder_footer_widget.dart';

class ReminderDaySelectsWidget extends StatefulWidget {
  const ReminderDaySelectsWidget({
    super.key,
  });

  @override
  State<ReminderDaySelectsWidget> createState() =>
      _ReminderDaySelectsWidgetState();
}

class _ReminderDaySelectsWidgetState extends State<ReminderDaySelectsWidget> {
  int selectedDayIndex = -1;
  @override
  Widget build(BuildContext context) {
    const dayofWeek = ["SU", "MO", "TU", "WE", "TH", "FR", "SA"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
          7,
          (index) {
            final bool isSelected = selectedDayIndex == index;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDayIndex = index;
                    });
                   SaveChange.day = dayofWeek[index];
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? Colors.grey : Colors.transparent,
                      border: Border.all(
                        color:
                            isSelected ? Colors.grey : const Color(0xFFA1A4B2),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        dayofWeek[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
