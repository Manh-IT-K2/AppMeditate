import 'package:cloud_firestore/cloud_firestore.dart';

class MusicsModel {
  final String id;
  final String title;
  final String author;
  final String image;
  final String url;
  final String idTopic;
  final String idSleep;
  final String idMeditation;
  final String meditation;
  final String genres;

  MusicsModel(
      {required this.id,
      required this.title,
      required this.author,
      required this.image,
      required this.url,
      required this.idTopic,
      required this.idSleep,
      required this.idMeditation,
      required this.meditation,
      required this.genres});

  // convert an object to a json String
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "author": author,
      "image": image,
      "url": url,
      "idTopic": idTopic,
      "idSleep": idSleep,
      "idMeditation": idMeditation,
      "meditation": meditation,
      "genres": genres
    };
  }

  // Map User fetched from Firebase to Usermodel
  factory MusicsModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) {
      throw Exception('Data is null !');
    }
    return MusicsModel(
        id: data["id"],
        title: data["title"],
        author: data["author"],
        image: data["image"],
        url: data["url"],
        idTopic: data["idTopic"],
        idSleep: data["idSleep"],
        idMeditation: data["idMeditation"],
        meditation: data["meditation"],
        genres: data["genres"]);
  }
  factory MusicsModel.fromJson(Map<String, dynamic> json) {
    return MusicsModel(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        image: json["image"],
        url: json["url"],
        idTopic: json["idTopic"],
        idSleep: json["idSleep"],
        idMeditation: json["idMeditation"],
        meditation: json["meditation"],
        genres: json["genres"]);
  }
}
