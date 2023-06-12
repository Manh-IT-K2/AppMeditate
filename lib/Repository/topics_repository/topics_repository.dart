// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:meditation_app/model/topics_model.dart';

// abstract class TopicStorage{
//   Future<List<Topic>> Load();
// }
// class AssetTopicStorage extends TopicStorage{
//   @override
//   Future<List<Topic>> Load() async{
//     if(kDebugMode){// nếu build ra bản reply rồi thì không delay nữa
//       await Future.delayed(const Duration(seconds: 2));
//     }
//     final jsonContent  = await rootBundle.loadString("mock/topics/topics.json");// đọc string data từ file json
//     final List<dynamic> jsonData = jsonDecode(jsonContent);// decode(giải mã) ra dạng json
//     return jsonData.map((e) => Topic.fromJson(e)).toList();// trả về 1 list 
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:meditation_app/model/topics_model.dart';

class ToppicsRepository extends GetxController {
  static ToppicsRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<TopicsModel>> getTopicList() async{
    final topicList = <TopicsModel>[];
    final topicsRef = _db.collection("topics");
    final querySnapshot = await topicsRef.get();
    for(var docSnapshot in querySnapshot.docs){
      final topic = TopicsModel.fromSnapshot(docSnapshot);
      topicList.add(topic);
    }
    return topicList;
  }
}