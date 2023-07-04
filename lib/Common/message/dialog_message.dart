import 'package:flutter/material.dart';
import 'package:meditation_app/Utils/theme.dart';
import 'package:meditation_app/controller/language_controller.dart';

class DialogMessage {
  static void show(var context, String text) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(      
          children: [
            const Icon(
              Icons.error,
              size: 30,
              color: Colors.red,
            ),
            const SizedBox(width: 5,),
            Text(
             translation(context).txtError,
              style: Primaryfont.bold(20).copyWith(color: Colors.red),
            ),
          ],
        ),
        content: Text(
          text,
          style: Primaryfont.medium(14).copyWith(color: Colors.red),
        ),
        actions: [
          TextButton(
            child: Text(
              "OK",
              style: Primaryfont.bold(16).copyWith(color: Colors.black),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
