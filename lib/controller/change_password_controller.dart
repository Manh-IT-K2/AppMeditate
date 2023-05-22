import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Repository/users_repository/users_repository.dart';

class ChangePasswordController {
  static ChangePasswordController get instance => Get.find();

  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  final userRepo = Get.put(UsersRepository());

  Future<bool> checkPassword(String userName, String passWord) async {
    return await userRepo.checkPassword(userName, passWord);
  }
  Future<void> updatePassword(String userId, String newPassword) async{
    await userRepo.updatePassword(userId, newPassword);
  }
}
