import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/language_controller.dart';

var otp;
class OTPScreen extends StatefulWidget {
  const OTPScreen({
    super.key,
    required this.text,
    required this.onPressed,
    });

  final String text;
  final Function() onPressed;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int _start = 60;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer.cancel();
        }
      });
    });
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(translation(context).tOtpTitle,
                  style: Primaryfont.bold(100).copyWith(color: Colors.black),),
              Text(translation(context).tOtpSubTitle.toUpperCase(),
                  style: Primaryfont.bold(14).copyWith(color: Colors.black),),
              const SizedBox(
                height: 40.0,
              ),
              Text("$_start s", style: Primaryfont.medium(20).copyWith(color: Colors.red),), 
              const SizedBox(
                height: 40.0,
              ),
              Text(
                '${translation(context).tOtpMessage} ${widget.text}',
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
                  onPressed: widget.onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shadowColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    translation(context).txtNext,
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
