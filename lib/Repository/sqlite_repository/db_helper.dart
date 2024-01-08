import 'package:flutter/foundation.dart';
import 'package:meditation_app/model/notification_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "Alarm";

  static Future<void> initDb() async {
    if(_db != null){
      return;
    }
    try {
      String _path = await getDatabasesPath() + "Alarm.db";
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          if (kDebugMode) {
            print("Creating a new one");
          }
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title STRING,"
            "subTitle STRING,"
            "time STRING)",
          );
        }
      );
    } catch (e) {
      if (kDebugMode) {
        print("error connection db : $e");
      }
    }
  }

  static Future<int> insert(NotificationModel? notificationModel) async {
    if (kDebugMode) {
      print("insert function called");
    }
    return await _db?.insert(_tableName, notificationModel!.toJson()) ?? 1;
  }
  
  static Future<List<Map<String,dynamic>>> query() async {
    if (kDebugMode) {
      print("query function called");
    }
    return await _db!.query(_tableName);
  }

  static delete(NotificationModel notificationModel) async {
    await _db!.delete(_tableName, where: "id=?", whereArgs: [notificationModel.id]);
  }
  
}