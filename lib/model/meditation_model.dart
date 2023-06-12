import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MeditationModel {
  final String id;
  final String title;
  final String thumbnail;
  final String bgColor;
  final String titleColor;

  MeditationModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.bgColor,
    required this.titleColor
  });

  // convert an object meditations to a json string
  Map<String,dynamic> toJson(){
    return {
      "id": id,
      "title": title,
      "thumbnail": thumbnail,
      "bgColor": bgColor,
      "titleColor": titleColor
    };
  }

  // Map meditations fetched from firebase to meditationmodel
  factory MeditationModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    final data =  document.data();
    if(data == null){
      throw Exception("Data is null !");
    }
    return MeditationModel(
      id: data["id"], 
      title: data["title"], 
      thumbnail: data["thumbnail"], 
      bgColor: data["bgColor"], 
      titleColor: data["titleColor"]);
  }
}

extension GetBgColor on MeditationModel {
  Color get colorBg => Color (int.parse(bgColor));
  Color get textColor => Color(int.parse(titleColor));
}