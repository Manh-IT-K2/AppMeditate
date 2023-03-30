import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:meditation_app/model/meditatemodel.dart';

abstract class MeditateStorage{
  Future<List<Meditate>> Load();
}
class AssetMeditateStorage extends MeditateStorage{
  @override
  Future<List<Meditate>> Load() async{
    if(kDebugMode){// nếu build ra bản reply rồi thì không delay nữa
      await Future.delayed(Duration(seconds: 1));
    }
    final jsonContent  = await rootBundle.loadString("mock/meditates/choosetopic.json");
    final List<dynamic> jsonData = jsonDecode(jsonContent);
    return jsonData.map((e) => Meditate.fromJson(e)).toList();
  }
}