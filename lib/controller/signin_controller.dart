import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Repository/users_repository/users_repository.dart';

class SignInController extends GetxController{
  static SignInController get instance => Get.find();

  final userName = TextEditingController();
  final passWord = TextEditingController();

  final userRepo = Get.put(UsersRepository());

  Future<bool> LogIn(String userName, String passWord) async {
    return await userRepo.checkUserNamePassword(userName, passWord);
  }

}