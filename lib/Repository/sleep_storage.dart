import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:meditation_app/model/sleepmodel.dart';

abstract class SleepStorage{
  Future<List<Sleep>> Load();
}
class AssetSleepStorage extends SleepStorage{
  @override
  Future<List<Sleep>> Load() async{
    if(kDebugMode){// nếu build ra bản reply rồi thì không delay nữa
      await Future.delayed(Duration(seconds: 1));
    }
    final jsonContent  = await rootBundle.loadString("mock/sleeps/topicsleep.json");
    final List<dynamic> jsonData = jsonDecode(jsonContent);
    return jsonData.map((e) => Sleep.fromJson(e)).toList();
  }
}