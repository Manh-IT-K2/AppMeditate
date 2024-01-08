import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meditation_app/Repository/statisticals_repository/currentstreak_repository.dart';
import 'package:meditation_app/controller/editprofile_controller.dart';
import 'package:meditation_app/model/currentstreak_model.dart';

class CurrentStreakController extends GetxController {
  static CurrentStreakController get instance => Get.find();
  final currentStreakRepo = Get.put(CurrentStreakRepository());
  final idUser = Get.put(EditProfileController());

  // create currentStreak
  Future<void> createCurrentStreak(CurrentStreakModel model) async {
    await currentStreakRepo.createCurrentStreak(model);
  }

  // get currentStreak by userId
  Future<CurrentStreakModel?> getCurrentStreakByUser(String userId) async {
    return await currentStreakRepo.getCurrentStreakByUser(userId);
  }

  // check currentStreak
  Future<bool> checkCurrentStreak(String userId) async {
    return await currentStreakRepo.checkCurrentStreak(userId);
  }

  // check date currentstreak
  Future<bool> checkDateCurrentStreak(String id, String date) async {
    return await currentStreakRepo.checkDateCurrentStreak(id, date);
  }

  // check behind date now exit
  Future<bool> checkDateBehindNow(String id, String date) async {
    return await currentStreakRepo.checkDateBehindNow(id, date);
  }

  // update count currentStreak
  Future<void> updateCountCurrentStreak(String id, int count) async {
    await currentStreakRepo.updateCountCurrentStreak(id, count);
  }

  // add date now
  Future<void> addDateNow(String id, String date) async {
    await currentStreakRepo.addDateNow(id, date);
  }

  // get date now
  String dateStatistical() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    String formattedDay = DateFormat.E().format(now);
    return "$formattedDay $formattedDate";
  }

  // get count streak
  Future<int> countStreak() async {
    final userModel = await idUser.getUser();
    int count = 0;
    final idus = await idUser.getUser();
    final currentStreakByUser = await getCurrentStreakByUser(idus!.id!);
    String idCurrentStreak = currentStreakByUser?.id ?? "";
    if (await checkDateBehindNow(idCurrentStreak, dateStatistical())) {
      updateCountCurrentStreak(idCurrentStreak, 0);
      count = 0;
    } else {
      final streakModel = await getCurrentStreakByUser(userModel!.id!);
      count = streakModel!.streakCount;
    }
    return count;
  }
}
