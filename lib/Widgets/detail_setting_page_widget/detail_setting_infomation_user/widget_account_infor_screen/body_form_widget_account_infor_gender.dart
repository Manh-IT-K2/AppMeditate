import 'package:flutter/material.dart';
import 'package:meditation_app/Utils/theme.dart';

List<String> options = ["male", "female"];

class BodyFormWidgetAccountInforGender extends StatelessWidget {
  const BodyFormWidgetAccountInforGender({
    super.key,
    required this.size,
    required this.gender,
    required this.sWidth,
  });

  final Size size;
  final double sWidth;
  final ValueNotifier<String> gender;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Gender",
          style: Primaryfont.medium(16),
          textAlign: TextAlign.start,
        ),
        SizedBox(
          width: size.width - 60,
          height: 80,
          child: ValueListenableBuilder(
            valueListenable: gender,
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width / 2 - 40,
                    child: RadioListTile(
                        title: const Text("Male"),
                        activeColor: Colors.pink,
                        value: options[0],
                        groupValue: value,
                        onChanged: (newValue) {
                          if (newValue != null) {
                            gender.value = newValue;
                          }
                        }),
                  ),
                  SizedBox(
                    width: size.width / 2 - sWidth,
                    child: RadioListTile(
                      activeColor: Colors.pink,
                      title: const Text("Female"),
                      value: options[1],
                      groupValue: value,
                      onChanged: (newValue) {
                        if (newValue != null) {
                          gender.value = newValue;
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
