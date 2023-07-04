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

  //
  Future<List<MusicsModel>> getListFavouriteByUser() async {
    final userModel = await idUser.getUser();
    List<MusicsModel> listMusic = await music.getAllMusic();
    List<StatisticalModel> listStatistical = await getStatistical();

    List<MusicsModel> listMusicByUser = [];
    for(MusicsModel musicModel in listMusic){
      for(StatisticalModel statisticalModel in listStatistical){
        if(musicModel.id == statisticalModel.idMusic && statisticalModel.idUser!.contains(userModel!.id)){
          listMusicByUser.add(musicModel);
        }
      }
    }
    return listMusicByUser;
  }
  // get statistical
  Future<List<StatisticalModel>> getStatistical() async {
    return await statisticalRepo.getStatistical();
  }

  // get List Statistical Of RelaxationMusic to dispaly view music
  Future<List<StatisticalModel>> getListStatisticalOfRelaxationMusic() async {
    List<MusicsModel> musicListJass =
        await music.getMusicMeditationRelaxationJazz();
    List<MusicsModel> musicListPiano =
        await music.getMusicMeditationRelaxationPiano();
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
  Future<int?> getTotalViewRelaxationMusic() async {
    List<StatisticalModel> statisticalList = await getListStatisticalOfRelaxationMusic();

    if (statisticalList.isEmpty) {
      return null; // Hoặc giá trị mặc định khác tuỳ thuộc vào yêu cầu của bạn
    }
    int totalViews = 0;
    for (var b in statisticalList) {
      totalViews += b.view!;
    }
    return totalViews;
  }

  // get total favourite of music CourseBasic
  Future<int?> getTotalFavouriteRelaxationMusic() async {
    List<StatisticalModel> matchingStatisticalList = await getListStatisticalOfRelaxationMusic();
    if(matchingStatisticalList.isEmpty){
      return null;
    }
    int? totalFavourite = matchingStatisticalList
        .map((statistical) => statistical.favourite)
        .reduce(
            (previousValue, currentValue) => previousValue! + currentValue!);
    return totalFavourite;
  }

   // get List Statistical Of EnglishPodcast to dispaly view music
  Future<List<StatisticalModel>> getListStatisticalOfEnglishPodcast() async {
    List<MusicsModel> musicListMaleVoice =
        await music.getMusicMeditationPodcastMaleVoice();
    List<MusicsModel> musicListFemaleVoice =
        await music.getMusicMeditationPodcastFemaleVoice();
    List<StatisticalModel> statisticalList = await getStatistical();
    Set<String> addedIds = <String>{};
    List<StatisticalModel> matchingStatisticalList = [];

    for (MusicsModel music in musicListMaleVoice) {
      for (MusicsModel musics in musicListFemaleVoice) {
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
  Future<int?> getTotalViewEnglishPodcast() async {
    List<StatisticalModel> statisticalList = await getListStatisticalOfEnglishPodcast();

    if (statisticalList.isEmpty) {
      return null; // Hoặc giá trị mặc định khác tuỳ thuộc vào yêu cầu của bạn
    }
    int totalViews = 0;
    for (var b in statisticalList) {
      totalViews += b.view!;
    }
    return totalViews;
  }

  // get total favourite of music CourseBasic
  Future<int?> getTotalFavouriteEnglishPodcast() async {
    List<StatisticalModel> matchingStatisticalList = await getListStatisticalOfEnglishPodcast();
    if(matchingStatisticalList.isEmpty){
      return null;
    }
    int? totalFavourite = matchingStatisticalList
        .map((statistical) => statistical.favourite)
        .reduce(
            (previousValue, currentValue) => previousValue! + currentValue!);
    return totalFavourite;
  }

  // get statistical by most views
  Future<List<StatisticalModel>> getStatisticalByMostViews() async {
    return await statisticalRepo.getStatisticalByMostViews();
  }

  // get music by most views
  Future<List<MusicsModel>> getMusicByMostViews() async {
    List<MusicsModel> listMusic = await music.getAllMusic();
    List<StatisticalModel> listStatistical = await getStatisticalByMostViews();

    Map<String, int> viewsMap = {}; // Ánh xạ idMusic với số lượt xem
    List<MapEntry<String, int>> tempViewsList = []; // Danh sách tạm thời

    // Tạo ánh xạ idMusic với số lượt xem
    for (StatisticalModel statistical in listStatistical) {
      viewsMap[statistical.idMusic] = statistical.view!;
    }
    // Tạo danh sách tạm thời từ ánh xạ đã tạo
    for (var entry in viewsMap.entries) {
      tempViewsList.add(entry);
    }

    // Sắp xếp danh sách tạm thời theo số lượt xem giảm dần
    tempViewsList.sort((a, b) => b.value.compareTo(a.value));

    List<MusicsModel> listMusicByMostView = [];

    // Thêm bài hát vào listMusicByMostView theo thứ tự đã sắp xếp
    for (var entry in tempViewsList) {
      String musicId = entry.key;
      for (MusicsModel music in listMusic) {
        if (music.id == musicId) {
          listMusicByMostView.add(music);
          break;
        }
      }
    }
    return listMusicByMostView;
  }


  // check favourite
  Future<bool> checkFavourite(String idMusic) async {
    final userModel = await idUser.getUser();
    return statisticalRepo.checkFavouriteOrDownload(idMusic, userModel!.id!);
  }
  // check favourite
  Future<bool> checkDownload(String idMusic) async {
    final userModel = await idUser.getUser();
    return statisticalRepo.checkFavouriteOrDownload(idMusic, "${userModel!.id!}DL");
  }

  // delete idUser favourite
  Future<void> deleteIdUserFavourite(String id) async {
    final userModel = await idUser.getUser();
    await statisticalRepo.deleteIdUser(id, userModel!.id!);
  }

  // delete idUser download
  Future<void> deleteIdUserDownload(String id) async {
    final userModel = await idUser.getUser();
    await statisticalRepo.deleteIdUser(id, "${userModel!.id!}DL");
  }

  // delete full idUser download when delete app
  Future<void> deleteFullByUserId() async {
    final userModel = await idUser.getUser();
    if(userModel == null){
      return;
    }else{
       await statisticalRepo.deleteFullByUserId("${userModel.id}DL");
    }
  }

  // add idUser
  Future<void> addIdUser(String id, String idUser) async {
    await statisticalRepo.addIdUser(id, idUser);
  }
}
