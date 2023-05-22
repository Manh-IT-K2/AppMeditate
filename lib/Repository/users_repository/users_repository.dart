import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/model/users_model.dart';

class UsersRepository extends GetxController {
  static UsersRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // create user
  createUsers(UsersModel users) async {
    DocumentReference docRef =
        await _db.collection("users").add(users.toJson());
    String uid = docRef.id;
    // thêm uid vào tài liệu
    await docRef.set({"id": uid}, SetOptions(merge: true));
    Get.snackbar("Success", "You account has been created.",
        icon: const Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green);
  }

  // update user
  Future<void> updateUser(UsersModel user, String id) async {
    try {
      await _db.collection("users").doc(id).update(user.toJson());
    } catch (e) {
      if (kDebugMode) {
        print('Error updating user data: $e');
      }
    }
  }

  // update avata user
  Future<void> updateAvata(String userId, String image) async{
    try {
      await _db.collection("users").doc(userId).update({"image": image});
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // update type Image
  Future<void> updateTypeImage(String userId, bool type) async {
    try {
      await _db.collection("users").doc(userId).update({"typeImage": type});
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
  
  // update password
  Future<void> updatePassword(String userId, String newPassword) async {
    try {
      await _db.collection("users").doc(userId).update({"passWord": newPassword});
    } catch (e) {
      // handle error
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // update phone
  Future<void> updatePhone(String userId, String phone) async {
    try {
      await _db.collection("users").doc(userId).update({"phone": phone});
    } catch (e) {
      // handle error
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }


  // update email
  Future<void> updateEmail(String userId, String email) async {
    try {
      await _db.collection("users").doc(userId).update({"email": email});
    } catch (e) {
      // handle error
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // update username
  Future<void> updateUsername(String userId, String userName) async {
    try {
      await _db.collection("users").doc(userId).update({"userName" : userName, "statusChageUser": 1});
    } catch (e) {
      if(kDebugMode){
        print(e.toString());
      }
    }
  }

  // check password
  Future<bool> checkPassword(String userName, String passWord) async{
    QuerySnapshot querySnapshot = await _db.collection("users")
    .where("userName",isEqualTo: userName)
    .get();
    final isPassword = querySnapshot.docs[0]["passWord"];
    return isPassword == passWord;
  }

  // get user with ussername
  Future<UsersModel> getUserDetail(String userName) async {
    final snapshot = await _db
        .collection("users")
        .where("userName", isEqualTo: userName)
        .get();
    final userData =
        snapshot.docs.map((e) => UsersModel.fromSnapshot(e)).single;
    return userData;
  }

  // get user with phone
  Future<UsersModel> getUserWithPhone(String phone) async {
    final snapshot = await _db
        .collection("users")
        .where("phone", isEqualTo: phone)
        .get();
    final userData =
        snapshot.docs.map((e) => UsersModel.fromSnapshot(e)).single;
    return userData;
  }

  // get user with email
  Future<UsersModel> getUserWithEmail(String email) async {
    final snapshot = await _db
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
    final userData =
        snapshot.docs.map((e) => UsersModel.fromSnapshot(e)).single;
    return userData;
  }


  //check username already exists or not
  Future<bool> checkUserName(String userName) async {
    // Lấy tất cả các documents có trường "username" bằng với giá trị đã nhập vào từ người dùng
    QuerySnapshot querySnapshot = await _db
        .collection('users')
        .where('userName', isEqualTo: userName)
        .get();
    if (querySnapshot.size != 0) {
      return true;
    } else {
      return false;
    }
  }

  //check phone already exists or not
  Future<bool> checkPhone(String phone) async {
    // Lấy tất cả các documents có trường "username" bằng với giá trị đã nhập vào từ người dùng
    QuerySnapshot querySnapshot = await _db
        .collection('users')
        .where('phone', isEqualTo: phone)
        .get();
    if (querySnapshot.size != 0) {
      return true;
    } else {
      return false;
    }
  }

  //check email already exists or not
  Future<bool> checkEmail(String email) async {
    // Lấy tất cả các documents có trường "username" bằng với giá trị đã nhập vào từ người dùng
    QuerySnapshot querySnapshot = await _db
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (querySnapshot.size != 0) {
      return true;
    } else {
      return false;
    }
  }

  // check username and password login
  Future<bool> checkUserNamePassword(String userName, String passWord) async {
    QuerySnapshot querySnapshot = await _db
        .collection('users')
        .where('userName', isEqualTo: userName)
        .get();
    // Kiểm tra xem có bất kỳ document nào thỏa mãn điều kiện trên hay không
    if (querySnapshot.size == 0) {
      return false; // Không tìm thấy tài khoản với username đã nhập vào
    }
    // Kiểm tra xem password có trùng khớp với password được lưu trong Firestore không
    String savedPassword = querySnapshot.docs[0]['passWord'];
    return savedPassword == passWord;
  }
}
