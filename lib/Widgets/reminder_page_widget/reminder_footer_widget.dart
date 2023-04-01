
import 'package:flutter/material.dart';
import 'package:meditation_app/Constant/colors.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Pages/container_page.dart';
import 'package:meditation_app/Utils/theme.dart';

class ReminderFooterWidget extends StatelessWidget {
  const ReminderFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed('$ContainerPage');
              },
              textColor: Colors.white,
              color: kColorPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(38),
              ),
              child: Text(
                txtSave,
                style: Primaryfont.medium(14),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Text(
                txtNothank,
                style: Primaryfont.medium(14).copyWith(color: kColorDartGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}