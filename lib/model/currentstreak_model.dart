import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentStreakModel {
  final String? id;
  final List<String>? date;
  final String userId;
  final int streakCount;

  CurrentStreakModel(
      {this.id,
      this.date,
      required this.userId,
      required this.streakCount});

  // convert an object to a json string
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "date": date,
      "userId": userId,
      "streakCount": streakCount,
    };
  }

  // map fetched from firebase to statisticalmodel
  factory CurrentStreakModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) {
      throw Exception("Data is null !");
    }
    return CurrentStreakModel(
      id: data["id"],
      date: List<String>.from(data["date"]),
      userId: data["userId"],
      streakCount: data["streakCount"],
    );
  }
}
