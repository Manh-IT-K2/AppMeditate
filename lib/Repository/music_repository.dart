import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:meditation_app/model/musics_model.dart';

class MusicRepository extends GetxController {
  static MusicRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  // get list music
  Future<List<MusicsModel>> getMusicList(String idTopic) async {
    final musicList = <MusicsModel>[];
    final musicsRef =
        _db.collection('musics').where("idTopic", isEqualTo: idTopic);
    final querySnapshot = await musicsRef.get();
    for (var docSnapshot in querySnapshot.docs) {
      final music = MusicsModel.fromDocumentSnapshot(docSnapshot);
      musicList.add(music);
    }
    return musicList;
  }

  // get list music chose meditation
  Future<List<MusicsModel>> getMusicMeditate(String idMeditation, String idTopic) async {
    final list = <MusicsModel>[];
    final listRef = _db.collection('musics').where("idTopic", isEqualTo: idTopic).where("idMeditation", isEqualTo: idMeditation). where("meditation", isEqualTo: "meditate");
    final querySnapshot = await listRef.get();
    for(var docSnapshot in querySnapshot.docs){
      final music = MusicsModel.fromDocumentSnapshot(docSnapshot);
      list.add(music);
    }
    return list;
  }

  // get list music chose sleep
  Future<List<MusicsModel>> getMusicSleep(String idSleep, String idTopic) async {
    final list = <MusicsModel>[];
    final listRef = _db.collection('musics').where("idTopic", isEqualTo: idTopic).where("idSleep", isEqualTo: idSleep).where("meditation", isEqualTo: "sleep");
    final querySnapshot = await listRef.get();
    for(var docSnapshot in querySnapshot.docs){
      final music = MusicsModel.fromDocumentSnapshot(docSnapshot);
      list.add(music);
    }
    return list;
  }

  // get list music chose sleep
  Future<List<MusicsModel>> getMusicMeditationCoursePiano(String idTopic) async {
    final list = <MusicsModel>[];
    final listRef = _db.collection('musics').where("idTopic", isEqualTo: idTopic).where("meditation", isEqualTo: "CourseBasic").where("genres", isEqualTo: "piano");
    final querySnapshot = await listRef.get();
    for(var docSnapshot in querySnapshot.docs){
      final music = MusicsModel.fromDocumentSnapshot(docSnapshot);
      list.add(music);
    }
    return list;
  }

  // get list music chose sleep
  Future<List<MusicsModel>> getMusicMeditationCourseJazz(String idTopic) async {
    final list = <MusicsModel>[];
    final listRef = _db.collection('musics').where("idTopic", isEqualTo: idTopic).where("meditation", isEqualTo: "CourseBasic").where("genres", isEqualTo: "jazz");
    final querySnapshot = await listRef.get();
    for(var docSnapshot in querySnapshot.docs){
      final music = MusicsModel.fromDocumentSnapshot(docSnapshot);
      list.add(music);
    }
    return list;
  }

}
