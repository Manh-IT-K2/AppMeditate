import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:meditation_app/model/musics_model.dart';

class MusicRepository extends GetxController {
  static MusicRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  // get list music
Future<List<MusicsModel>?> getMusicList(String idTopic) async {
  try {
    print("cc " + idTopic);
    final musicList = <MusicsModel>[];
    final musicsRef =
        _db.collection('musics').where("idTopic", isEqualTo: idTopic);
    final querySnapshot = await musicsRef.get();

    for (var docSnapshot in querySnapshot.docs) {
      final music = MusicsModel.fromDocumentSnapshot(docSnapshot);
      musicList.add(music);
    }

    return musicList.isEmpty ? null : musicList;
  } catch (e) {
    if (kDebugMode) {
      print("Error fetching music list: $e");
    }
    return null;
  }
}


  // get Detail music
  Future<MusicsModel> getDetailMusic(String id) async {
    final snapshot =
        await _db.collection("musics").where("id", isEqualTo: id).get();
    final music =
        snapshot.docs.map((e) => MusicsModel.fromDocumentSnapshot(e)).single;
    return music;
  }

  // get list music chose meditation
  Future<List<MusicsModel>> getMusicMeditate(
      String idMeditation, String idTopic) async {
    final list = <MusicsModel>[];
    final listRef = _db
        .collection('musics')
        .where("idTopic", isEqualTo: idTopic)
        .where("idMeditation", isEqualTo: idMeditation)
        .where("meditation", isEqualTo: "meditate");
    final querySnapshot = await listRef.get();
    for (var docSnapshot in querySnapshot.docs) {
      final music = MusicsModel.fromDocumentSnapshot(docSnapshot);
      list.add(music);
    }
    return list;
  }

  // get list music chose meditation
  Future<List<MusicsModel>> getMusicMeditateDailyThought(String idTopic) async {
    final list = <MusicsModel>[];
    final listRef = _db
        .collection('musics')
        .where("idTopic", isEqualTo: idTopic)
        .where("meditation", isEqualTo: "DailyThought");
    final querySnapshot = await listRef.get();
    for (var docSnapshot in querySnapshot.docs) {
      final music = MusicsModel.fromDocumentSnapshot(docSnapshot);
      list.add(music);
    }
    return list;
  }

  // get list music chose sleep
  Future<List<MusicsModel>> getMusicSleep(
      String idSleep, String idTopic) async {
    final list = <MusicsModel>[];
    final listRef = _db
        .collection('musics')
        .where("idTopic", isEqualTo: idTopic)
        .where("idSleep", isEqualTo: idSleep)
        .where("meditation", isEqualTo: "sleep");
    final querySnapshot = await listRef.get();
    for (var docSnapshot in querySnapshot.docs) {
      final music = MusicsModel.fromDocumentSnapshot(docSnapshot);
      list.add(music);
    }
    return list;
  }

  // get list music chose sleep
  Future<List<MusicsModel>> getMusicMeditationRelaxationPiano(
      String idTopic) async {
    final list = <MusicsModel>[];
    final listRef = _db
        .collection('musics')
        .where("idTopic", isEqualTo: idTopic)
        .where("meditation", isEqualTo: "RelaxationMusic")
        .where("genres", isEqualTo: "piano");
    final querySnapshot = await listRef.get();
    for (var docSnapshot in querySnapshot.docs) {
      final music = MusicsModel.fromDocumentSnapshot(docSnapshot);
      list.add(music);
    }
    return list;
  }

  // get list music chose sleep
  Future<List<MusicsModel>> getMusicMeditationRelaxationJazz(
      String idTopic) async {
    final list = <MusicsModel>[];
    final listRef = _db
        .collection('musics')
        .where("idTopic", isEqualTo: idTopic)
        .where("meditation", isEqualTo: "RelaxationMusic")
        .where("genres", isEqualTo: "jazz");
    final querySnapshot = await listRef.get();
    for (var docSnapshot in querySnapshot.docs) {
      final music = MusicsModel.fromDocumentSnapshot(docSnapshot);
      list.add(music);
    }
    return list;
  }

  // get list music chose sleep
  Future<List<MusicsModel>> getMusicMeditationPodcastMaleVoice(
      String idTopic) async {
    final list = <MusicsModel>[];
    final listRef = _db
        .collection('musics')
        .where("idTopic", isEqualTo: idTopic)
        .where("meditation", isEqualTo: "EnglishPodcast")
        .where("genres", isEqualTo: "malevoice");
    final querySnapshot = await listRef.get();
    for (var docSnapshot in querySnapshot.docs) {
      final music = MusicsModel.fromDocumentSnapshot(docSnapshot);
      list.add(music);
    }
    return list;
  }

  // get list music chose sleep
  Future<List<MusicsModel>> getMusicMeditationPodcastFemaleVoice(
      String idTopic) async {
    final list = <MusicsModel>[];
    final listRef = _db
        .collection('musics')
        .where("idTopic", isEqualTo: idTopic)
        .where("meditation", isEqualTo: "EnglishPodcast")
        .where("genres", isEqualTo: "femalevoice");
    final querySnapshot = await listRef.get();
    for (var docSnapshot in querySnapshot.docs) {
      final music = MusicsModel.fromDocumentSnapshot(docSnapshot);
      list.add(music);
    }
    return list;
  }
}
