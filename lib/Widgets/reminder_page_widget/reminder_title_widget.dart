
import 'package:flutter/material.dart';
import 'package:meditation_app/Utils/theme.dart';

class ReminderTitleWidget extends StatelessWidget {
  const ReminderTitleWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment
            .stretch, // các thằng con trong column giãn ra hết chiều rộng của màn hình
        children: [
          Expanded(
            child: FractionallySizedBox(
              heightFactor: 0.8,
              alignment: Alignment.topCenter,
              child: FittedBox(
                // cho thằng con co lại đúng bằng fractionallysizebox
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: Primaryfont.bold(24).copyWith(
                    height: 1.35,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FractionallySizedBox(
              heightFactor: 0.6,
              alignment: Alignment.topCenter,
              child: FittedBox(
                alignment: Alignment.centerLeft,
                child: Text(
                  subtitle,
                  style: Primaryfont.ligh(14).copyWith(
                    color: const Color(0xFFA1A4B2),
                    height: 1.65,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
