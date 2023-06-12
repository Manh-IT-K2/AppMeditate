import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:meditation_app/model/meditation_model.dart';

class MeditationRepository extends GetxController{
  static MeditationRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  // get list meditation
  Future<List<MeditationModel>> getMeditateList() async {
    final meditaionList = <MeditationModel>[];
    final meditationRef = _db.collection("meditates");
    final querySnapshot = await meditationRef.get();
    for(var docSnapshot in querySnapshot.docs){
      final meditations = MeditationModel.fromSnapshot(docSnapshot);
      meditaionList.add(meditations);
    }
    return meditaionList;
  }
}