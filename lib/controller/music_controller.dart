import 'package:get/get.dart';
import 'package:meditation_app/Repository/music_repository.dart';
import 'package:meditation_app/model/musics_model.dart';

class MusicController extends GetxController {
  static MusicController get instance => Get.find();
  final musicRepo = Get.put(MusicRepository());

  Future<List<MusicsModel>> getAllMusic(){
    return musicRepo.getMusicList();
  }
}