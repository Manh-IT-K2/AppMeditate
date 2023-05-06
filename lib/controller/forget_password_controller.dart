import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:meditation_app/Repository/authentication_repository/authentication_repository.dart';
import 'package:meditation_app/Repository/users_repository/users_repository.dart';
import 'package:meditation_app/model/users_model.dart';

//nslookup email.com
class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();
  final repoAuthentication = Get.put(AuthenticationRepository());
  final userRepo = Get.put(UsersRepository());
  final phone = TextEditingController(text: "(+84) ");
  final email = TextEditingController();
  final userName = TextEditingController();

  // Get phoneNo from user and pass it to auth repository for firebase authentication
  void phoneAuthentication(String phoneNo) {
    repoAuthentication.phoneAuthentication(phoneNo);
  }

  // check otp phone valid
  Future<bool> verifyOTP(String otp) async {
    return await repoAuthentication.verifyOTP(otp);
  }

  // get user with phone
  Future<UsersModel> getUserWithPhone(String phone) async {
    return await userRepo.getUserWithPhone(phone);
  }

  // get user with phone
  Future<UsersModel> getUserWithEmail(String email) async {
    return await userRepo.getUserWithEmail(email);
  }


  // check phone
  Future<bool> checkPhone(String phone) async {
    return await userRepo.checkPhone(phone);
  }

  // check email
  Future<bool> checkEmail(String email) async {
    return await userRepo.checkEmail(email);
  }

  void emailAuthentication(String email) {
    repoAuthentication.sendEmailVerification(email);
  }

  // send otp email
  sendOtpEmail(String email, String otpCode) async {
  String username = 'quanmanh901@gmail.com';
  String password = 'refihkajuqwjabay';

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, 'App Meditate')
    ..recipients.add(email)
    ..subject = 'OTP Code'
    ..text = 'Your OTP code is: $otpCode';

  try {
    final sendReport = await send(message, smtpServer);
    if (kDebugMode) {
      print('Message sent: $sendReport');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error occurred: $e');
    }
  }
}
}
