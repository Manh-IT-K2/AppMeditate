import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';

class UsersModel {
  final String id;
  final String userName;
  final String passWord;

  UsersModel({String? id, required this.userName, required this.passWord})
      : id = id ?? const Uuid().v4();
// chuyển đổi một đối tượng thành một chuỗi JSON. -- // convert an object to a JSON string.
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userName": userName,
      "passWord": passWord,
    };
  }

  // Step 1 - Map User fetched from Firebase to Usermodel
  factory UsersModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if(data == null){
      throw Exception('Data is null !');
    }
    return UsersModel(
      id: data["id"], 
      userName: data["userName"], 
      passWord: data["passWord"]);
  }
}
