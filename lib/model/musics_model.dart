import 'package:cloud_firestore/cloud_firestore.dart';

class MusicsModel {
  final String title;
  final String author;
  final String image;
  final String url;

  MusicsModel({
    required this.title,
    required this.author,
    required this.image,
    required this.url,
  });

  // convert an object to a json String
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "author": author,
      "image": image,
      "url": url,
    };
  }

  // Map User fetched from Firebase to Usermodel
  factory MusicsModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    if (data == null) {
      throw Exception('Data is null !');
    }
    return MusicsModel(
        title: data["title"],
        author: data["author"],
        image: data["image"],
        url: data["url"]);
  }
}
