import 'package:get/get.dart';
import 'package:meditation_app/Repository/statisticals_repository/statistical_repository.dart';
import 'package:meditation_app/controller/editprofile_controller.dart';
import 'package:meditation_app/controller/music_controller.dart';
import 'package:meditation_app/model/musics_model.dart';
import 'package:meditation_app/model/statistical_model.dart';

class StatisticalController extends GetxController {
  static StatisticalController get instance => Get.find();
  final statisticalRepo = Get.put(StatisticalRepository());
  final music = Get.put(MusicController());
  final idUser = Get.put(EditProfileController());
  

  // create statistical
  Future<void> createStatistical(StatisticalModel statistical) async {
    await statisticalRepo.createStatistical(statistical);
  }

  // get a detail statistical
  Future<StatisticalModel> getDetailStatistical(String idMusic) async {
    return await statisticalRepo.getDetailStatistical(idMusic);
  }

  // update view statisticals already exist
  Future<void> updateViewStatistical(String id, int view) async {
    await statisticalRepo.updateViewStatistical(id, view);
  }

  // update view statisticals already exist
  Future<void> updateFavouriteStatistical(String id, int favourite) async {
    await statisticalRepo.updateFavouriteStatistical(id, favourite);
  }

  // update view statisticals already exist
  Future<void> updateDownloadStatistical(String id, int download) async {
    await statisticalRepo.updateDownloadStatistical(id, download);
  }

  // check statistical already axists
  Future<bool> checkStatistical(String idMusic) async {
    return statisticalRepo.checkStatistical(idMusic);
  }

  // get statistical
  Future<List<StatisticalModel>> getStatistical() async {
    return await statisticalRepo.getStatistical();
  }

  // get List Statistical Of CourseBasic to dispaly view music
  Future<List<StatisticalModel>> getListStatisticalOfCourseBasic() async {
    List<MusicsModel> musicListJass =
        await music.getMusicMeditationCourseJazz();
    List<MusicsModel> musicListPiano =
        await music.getMusicMeditationCoursePiano();
    List<StatisticalModel> statisticalList = await getStatistical();

    Set<String> addedIds = <String>{};
    List<StatisticalModel> matchingStatisticalList = [];

    for (MusicsModel music in musicListPiano) {
      for (MusicsModel musics in musicListJass) {
        for (StatisticalModel statistical in statisticalList) {
          if (music.id == statistical.idMusic ||
              musics.id == statistical.idMusic) {
            if (!addedIds.contains(statistical.idMusic)) {
              matchingStatisticalList.add(statistical);
              addedIds.add(statistical.idMusic);
            }
          }
        }
      }
    }
    return matchingStatisticalList;
  }

  // get total view music
  Future<int?> getTotalViewCourseBasic() async {
    List<StatisticalModel> statisticalList =
        await getListStatisticalOfCourseBasic();
    int totalViews = 0;
    for (var b in statisticalList) {
      totalViews += b.view!;
    }
    return totalViews;
  }

  // get total favourite of music CourseBasic
  Future<int?> getTotalFavouriteCourseBasic() async {
    List<StatisticalModel> matchingStatisticalList = await getListStatisticalOfCourseBasic();
    int? totalFavourite = matchingStatisticalList
        .map((statistical) => statistical.favourite)
        .reduce((previousValue, currentValue) => previousValue! + currentValue!);
    return totalFavourite;
  }
 
  // check favourite
  Future<bool> checkFavourite(String idMusic) async {
    final userModel = await idUser.getUser();
    return statisticalRepo.checkFavourite(idMusic, userModel.id!);
  }

  // delete idUser
  Future<void> deleteIdUser(String id) async {
    final userModel = await idUser.getUser();
    await statisticalRepo.deleteIdUser(id, userModel.id!);
  }

  // add idUser
  Future<void> addIdUser(String id, String idUser) async {
    await statisticalRepo.addIdUser(id, idUser);
  }
}
