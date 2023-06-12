
// import 'dart:ui';

// import 'package:flutter/foundation.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// part 'topicmodel.freezed.dart';
// part 'topicmodel.g.dart';

// @freezed
// class Topic with _$Topic  {
//   const factory Topic({
//     required String title,
//     required String thumbnail,
//     required String color,
//     required String titleColor,

//   }) = _Topic;
//   factory Topic.fromJson(Map<String, Object?> json) => _$TopicFromJson(json);
// }
// extension GetBgColor on Topic{
//   Color get bgColor => Color(int.parse(color));// ép kiểu
//   Color get textColor => Color(int.parse(titleColor));
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopicsModel {

  final String id;
  final String title;
  final String thumbnail;
  final String titleColor;
  final String bgColor;

  TopicsModel({required this.id, required this.title, required this.thumbnail, required this.bgColor, required this.titleColor});

  // convert an object topics to a json string
  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "title": title,
      "thumbnail": thumbnail,
      "bgColor": bgColor,
      "titleColor": titleColor
    };
  }

  // map topics fetched from firebase to topicsmodel
  factory  TopicsModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    final data = document.data();
    if(data == null){
      throw Exception("Data is null !");
    }
    return TopicsModel(
      id: data["id"], 
      title: data["title"], 
      thumbnail: data["thumbnail"],
      bgColor: data["bgColor"],
      titleColor: data["titleColor"]);
  }
}
extension GetBgColor on TopicsModel{
  Color get colorBg => Color(int.parse(bgColor));
  Color get textColor => Color(int.parse(titleColor));
}   