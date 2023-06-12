import 'package:get/get.dart';
import 'package:meditation_app/Repository/sleep_repository/sleep_repository.dart';
import 'package:meditation_app/model/sleep_model.dart';

class SleepController extends GetxController{
  static SleepController get instance => Get.find();
  final sleepRepo = Get.put(SleepRepsitory());

  // get sleep list
  Future<List<SleepModel>> getSleepList() async {
    return await sleepRepo.getSleepList();
  }
}