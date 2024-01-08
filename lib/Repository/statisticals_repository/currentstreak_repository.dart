import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meditation_app/model/currentstreak_model.dart';

class CurrentStreakRepository extends GetxController {
  static CurrentStreakRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  // create currentStreak model
  createCurrentStreak(CurrentStreakModel currentStreak) async {
    DocumentReference docRef =
        await _db.collection("currentstreak").add(currentStreak.toJson());
    String uid = docRef.id;
    // add uid enter document
    await docRef.set({"id": uid}, SetOptions(merge: true));
  }

  // update count currentstreak
  Future<void> updateCountCurrentStreak(String id, int count) async {
    try {
      await _db
          .collection("currentstreak")
          .doc(id)
          .update({"streakCount": count});
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // get count currentstreak of userId
  Future<CurrentStreakModel?> getCurrentStreakByUser(String userId) async {
    final snapshot = await _db
        .collection("currentstreak")
        .where("userId", isEqualTo: userId)
        .get();

    if(snapshot.docs.isEmpty){
      return null;
    }
    final data = snapshot.docs
        .map((e) => CurrentStreakModel.fromDocumentSnapshot(e))
        .single;
    return data;
  }
  
  // check currentstreak userId exits
  Future<bool> checkCurrentStreak(String userId) async {
    final snapshot = await _db
        .collection("currentstreak")
        .where("userId", isEqualTo: userId)
        .get();

    if (snapshot.size != 0) {
      return true;
    }
    return false;
  }

  // get date now

  String previousDateFormatted() {
    DateTime now = DateTime.now();
    DateTime previousDay = now.subtract(Duration(days: 1)); // Lấy ngày trước đó
    String formattedDate = DateFormat('dd/MM/yyyy').format(previousDay);
    String formattedDay = DateFormat.E().format(previousDay);
    return "$formattedDay $formattedDate";
  }

  // check date exits
  Future<bool> checkDateCurrentStreak(String id, String date) async {
    // Lấy ngày trước ngày hiện tại (1 ngày trước)
    final snapshot = await _db.collection("currentstreak").doc(id).get();
    List<dynamic> dateList = snapshot.get("date");
    if(!dateList.contains(date) && dateList.contains(previousDateFormatted())) {
      return true;
    }
    return false;
  }

  // check date behind now
  Future<bool> checkDateBehindNow(String id, String date) async {
    final snapshot = await _db.collection("currentstreak").doc(id).get();
    List<dynamic> dateList = snapshot.get("date");
    if(!dateList.contains(previousDateFormatted())){
      return true;
    }
    return false;
  }
  // add date now
  Future<void> addDateNow(String id, String date) async {
    await _db.collection("currentstreak").doc(id).update({
      "date": FieldValue.arrayUnion([date])
    });
  }
}
