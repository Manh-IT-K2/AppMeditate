import 'package:get/get.dart';
import 'package:meditation_app/Repository/meditate_repository/meditate_repository.dart';
import 'package:meditation_app/model/meditation_model.dart';

class MeditionController extends GetxController{
  static MeditionController get instance => Get.find();
  final meditationRepo = Get.put(MeditationRepository());

  Future<List<MeditationModel>> getMeditateList() async {
    return await meditationRepo.getMeditateList();
  }
}