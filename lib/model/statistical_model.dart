import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticalModel {
  final String? id;
  final int? view;
  final int? favourite;
  final int? download;
  final List<String>? idUser;
  final String idMusic;
  final bool? listenedCount;
  final int? meditationMinute;
  final String? date;
  final int? currentStreak;


  StatisticalModel(
      {this.id,
      this.view,
      this.date,
      this.favourite,
      this.download,
      this.idUser,
      required this.idMusic,
      this.listenedCount, 
      this.meditationMinute, 
      this.currentStreak,});

  // convert an object to a json string
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "view": view,
      "date": date,
      "favourite": favourite,
      "download": download,
      "idUser": idUser,
      "idMusic": idMusic,
      "listenedCount": listenedCount,
      "meditationMinute": meditationMinute,
      "currentStreak": currentStreak,
    };
  }

  // map fetched from firebase to statisticalmodel
  factory StatisticalModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) {
      throw Exception("Data is null !");
    }
    return StatisticalModel(
      id: data["id"],
      view: data["view"],
      date: data["date"],
      favourite: data["favourite"],
      download: data["download"],
      idUser: List<String>.from(data["idUser"]),
      idMusic: data["idMusic"],
      listenedCount: data["listenedCount"],
      meditationMinute: data["meditationMinute"],
      currentStreak: data["currentStreak"],
    );
  }
}
