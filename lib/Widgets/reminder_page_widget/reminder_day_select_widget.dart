
import 'package:flutter/material.dart';

class ReminderDaySelectsWidget extends StatelessWidget {
  const ReminderDaySelectsWidget({
    super.key,
  });

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
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: const Color(0xFFA1A4B2),
                    ),
                  ),
                  child: Center(
                    child: Text(dayofWeek[index]),
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

