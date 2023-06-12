import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Repository/users_repository/users_repository.dart';
import 'package:meditation_app/controller/signin_controller.dart';
import 'package:meditation_app/model/users_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileController extends GetxController {
  static EditProfileController get instance => Get.find();

  final userName = TextEditingController();
  final userRepo = Get.put(UsersRepository());
  final userRepoo = Get.put(SignInController());

  // get detail user
  Future<UsersModel> getUser() async {
    return await userRepo.getUserDetail(await userRepoo.getStringUsername());
  }

  Future<UsersModel> getUserr(String userName) async {
    return await userRepo.getUserDetail(userName);
  }

  // update user
  Future<void> updateUser(UsersModel user, String id) async {
    await userRepo.updateUser(user, id);
  }

  // update phone
  Future<void> updatePhone(String userId, String phone) async {
    await userRepo.updatePhone(userId, phone);
  }

  //update email
  Future<void> updateEmail(String userId, String email) async {
    await userRepo.updateEmail(userId, email);
  }

  // update userName
  Future<void> updateUsername(String userId, String userName) async {
    await userRepo.updateUsername(userId, userName);
  }

  // update avata user
  Future<void> updateAvata(String userId, String image) async {
    await userRepo.updateAvata(userId, image);
  }

  // update type Image
  Future<void> updateTypeImage(String userId, bool type) async {
    await userRepo.updateTypeImage(userId, type);
  }
  
  // save color boder
  void saveColor(Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String colorString = color.value.toRadixString(16).padLeft(8, '0');
    await prefs.setString('myColor', colorString);
  }

  // get color boder
  Future<Color> getSavedColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String colorString = prefs.getString('myColor') ?? '000000';
    int colorValue = int.parse(colorString, radix: 16);
    return Color(colorValue);
  }
}
