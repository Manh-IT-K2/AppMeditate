import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Repository/users_repository/users_repository.dart';
import 'package:meditation_app/model/users_model.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  // Textfield Controller to get data from TextField
  final userName = TextEditingController();
  final passWord = TextEditingController();
  final rePassWord = TextEditingController();

  final userRepo = Get.put(UsersRepository());
  // create user
  Future<void> creadUser(UsersModel users) async {
    await userRepo.createUsers(users);
  }

  // check user name exist
  Future<bool> checkUserName(String userName) async {
    return await userRepo.checkUserName(userName);
  }

  // check validate Password
  bool isPasswordValid(String password) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return regex.hasMatch(password);
  }
  // check password strength
  String validatePassword(String password) {
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    else if(!password.contains(RegExp(r'[A-Z]'))){
      return 'Password must contain at least one uppercase letter';
    }
    else if(!password.contains(RegExp(r'[a-z]'))){
      return 'Password must contain at least one lowercase letter';
    }
    else if(!password.contains(RegExp(r'[0-9]'))){
      return 'Password must have at least one digit';
    } 
    else if(!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
      return 'Password must have at least one special character';
    }else{
      return '';
    }
    
  }
}
