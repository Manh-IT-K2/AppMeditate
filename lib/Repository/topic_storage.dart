import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:meditation_app/model/topicmodel.dart';

abstract class TopicStorage{
  Future<List<Topic>> Load();
}
class AssetTopicStorage extends TopicStorage{
  @override
  Future<List<Topic>> Load() async{
    if(kDebugMode){// nếu build ra bản reply rồi thì không delay nữa
      await Future.delayed(const Duration(seconds: 2));
    }
    final jsonContent  = await rootBundle.loadString("mock/topics/topics.json");// đọc string data từ file json
    final List<dynamic> jsonData = jsonDecode(jsonContent);// decode(giải mã) ra dạng json
    return jsonData.map((e) => Topic.fromJson(e)).toList();// trả về 1 list 
  }
}