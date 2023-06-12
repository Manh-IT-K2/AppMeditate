import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Repository/users_repository/users_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  final userName = TextEditingController();
  final passWord = TextEditingController();

  final userRepo = Get.put(UsersRepository());

  Future<bool> logIn(String userName, String passWord) async {
    return await userRepo.checkUserNamePassword(userName, passWord);
  }

  // savechange login
  void saveLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  //savechange login
  void saveUsername(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('Username', userName);
  }
  //get username with sharedpreferences login
  Future<String> getStringUsername() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('Username') ?? "";
 }
}