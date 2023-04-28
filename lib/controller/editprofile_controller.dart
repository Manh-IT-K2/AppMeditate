import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:meditation_app/Repository/users_repository/users_repository.dart';
import 'package:meditation_app/model/users_model.dart';


class EditProfileController extends GetxController {
  static EditProfileController get instance => Get.find();

  final userRepo = Get.put(UsersRepository());
  
  Future<UsersModel> getUser(String userName) async{
    // nếu build ra bản reply rồi thì không delay nữa
     if(kDebugMode){
      await Future.delayed(const Duration(seconds: 2));
    }
    return await userRepo.getUserDetail(userName);
  }

  updateUser(UsersModel user, String id) async{
    await userRepo.updateUser(user,id);
  }
}
