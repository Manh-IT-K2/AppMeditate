import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SleepModel {
  final String id;
  final String title;
  final String thumbnail;
  final String bgColor;
  final String titleColor;
  final String timeSleep;

  SleepModel(
      {required this.id,
      required this.title,
      required this.thumbnail,
      required this.bgColor,
      required this.titleColor,
      required this.timeSleep});

  // convert an object sleep to a json to string
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "thumbnail": thumbnail,
      "bgColor": bgColor,
      "titleColor": titleColor,
      "timeSleep": timeSleep
    };
  }

  // Map sleep fetched from firebase to sleepmodel
  factory SleepModel.fromShapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) {
      throw Exception("Data is null !");
    }
    return SleepModel(
        id: data["id"],
        title: data["title"],
        thumbnail: data["thumbnail"],
        bgColor: data["bgColor"],
        titleColor: data["titleColor"],
        timeSleep: data["timeSleep"]);
  }
}

extension GetBgColor on SleepModel {
  Color get colorBg => Color(int.parse(bgColor)); // ép kiểu
  Color get textColor => Color(int.parse(titleColor));
}
