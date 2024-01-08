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
  Future<UsersModel?> getUser() async {
    final username = await userRepoo.getStringUsername();
    if(username.isEmpty){
      return null;
    }else {
      return await userRepo.getUserDetail(username);
    }
  }

  Future<UsersModel> getUserr(String userName) async {
    return await userRepo.getUserDetail(userName);
  }

  // update user
  Future<void> updateUser(UsersModel user, String id) async {
    await userRepo.updateUser(user, id);
  }
  
  //
  Future<void> updateDowloadCellular(bool dowloadCellular) async {
    final id = await getUser();
    await userRepo.updateDowloadCellular(id!.id!, dowloadCellular);
  }

  // update do not disturb
  Future<void> updateDoNotDisturb(bool doNotDisturb) async {
    final id = await getUser();
    await userRepo.updateDoNotDisturb(id!.id!, doNotDisturb);
  }

  // update reminder time
  Future<void> updateReminderTime(String reminderTime) async {
    final id = await getUser();
    await userRepo.updateReminderTime(id!.id!, reminderTime);
  }

  // get dowload cellular
  Future<bool> getDowloadCellular() async {
    final userName = await userRepoo.getStringUsername(); 
    return await userRepo.getDowloadCellular(userName);
  }

  // get do not disturb
  Future<bool> getDoNotDisturb() async {
    final userName = await userRepoo.getStringUsername();
    return await userRepo.getDoNotDisturb(userName);
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
