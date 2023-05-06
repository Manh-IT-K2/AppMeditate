import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:meditation_app/Constant/text_string.dart';
import 'package:meditation_app/Utils/theme.dart';

var otp;
class OTPScreen extends StatelessWidget {
  const OTPScreen({
    super.key,
    required this.text,
    required this.onPressed,
    });

  final String text;
  final Function() onPressed;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(tOtpTitle,
                  style: Primaryfont.bold(100).copyWith(color: Colors.black)),
              Text(tOtpSubTitle.toUpperCase(),
                  style: Primaryfont.bold(14).copyWith(color: Colors.black)),
              const SizedBox(
                height: 40.0,
              ),
              Text(
                '$tOtpMessage $text',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20.0,
              ),
              OtpTextField(
                numberOfFields: 6,
                fillColor: Colors.black.withOpacity(0.1),
                filled: true,
                onSubmit: (code) {
                  otp = code;
                },
              ),
              Container(
                padding: const EdgeInsets.only(top: 30),
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shadowColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    "Next",
                    style: Primaryfont.bold(14).copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
