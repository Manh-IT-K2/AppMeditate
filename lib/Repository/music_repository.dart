import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:meditation_app/model/musics_model.dart';

class MusicRepository extends GetxController{
  static MusicRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<MusicsModel>> getMusicList() async {
  final musicList = <MusicsModel>[];
  final musicsRef = _db.collection('musics');
  final querySnapshot = await musicsRef.get();
  for (var docSnapshot in querySnapshot.docs) {
    final music = MusicsModel.fromDocumentSnapshot(docSnapshot);
    musicList.add(music);
  }
  return musicList;
}
}
