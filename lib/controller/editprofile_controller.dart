import 'package:get/get.dart';
import 'package:meditation_app/Repository/users_repository/users_repository.dart';
import 'package:meditation_app/model/users_model.dart';

class EditProfileController extends GetxController {
  static EditProfileController get instance => Get.find();

  final userRepo = Get.put(UsersRepository());

  // get detail user
  Future<UsersModel> getUser(String userName) async {
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
}
