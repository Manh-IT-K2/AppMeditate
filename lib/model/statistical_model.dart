import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticalModel {
  final String? id;
  final int? view;
  final int? favourite;
  final int? download;
  final List<String>? idUser;
  final String idMusic;


  StatisticalModel(
      {this.id,
      this.view,
      this.favourite,
      this.download,
      this.idUser,
      required this.idMusic});

  // convert an object to a json string
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "view": view,
      "favourite": favourite,
      "download": download,
      "idUser": idUser,
      "idMusic": idMusic,
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
      favourite: data["favourite"],
      download: data["download"],
      idUser: List<String>.from(data["idUser"]),
      idMusic: data["idMusic"],
    );
  }
}
