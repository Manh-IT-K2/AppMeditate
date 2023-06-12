import 'package:get/get.dart';
import 'package:meditation_app/Repository/music_repository.dart';
import 'package:meditation_app/controller/topics_contronller.dart';
import 'package:meditation_app/model/musics_model.dart';

class MusicController extends GetxController {
  static MusicController get instance => Get.find();
  final musicRepo = Get.put(MusicRepository());
  final idTopic = Get.put(TopicController());

  // get all music
  Future<List<MusicsModel>> getAllMusic() async {
    String id = await idTopic.getChoseTopic();
    return musicRepo.getMusicList(id);
  }

  // get list music meditation chose
  Future<List<MusicsModel>> getMusicMeditate(String idMeditation) async {
    String id = await idTopic.getChoseTopic();
    return musicRepo.getMusicMeditate(idMeditation, id);
  }

  // get list music meditation chose
  Future<List<MusicsModel>> getMusicSleep(String idSleep) async {
    String id = await idTopic.getChoseTopic();
    return musicRepo.getMusicSleep(idSleep, id);
  }

  // get list music meditation coursebasic piano
  Future<List<MusicsModel>> getMusicMeditationCoursePiano() async {
     String id = await idTopic.getChoseTopic();
    return await musicRepo.getMusicMeditationCoursePiano(id);
  }

  // get list music meditation coursebasic jazz
  Future<List<MusicsModel>> getMusicMeditationCourseJazz() async {
     String id = await idTopic.getChoseTopic();
    return await musicRepo.getMusicMeditationCourseJazz(id);
  }
  
}