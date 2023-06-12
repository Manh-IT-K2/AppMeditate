import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:meditation_app/model/sleep_model.dart';

class SleepRepsitory extends GetxController {
  static SleepRepsitory get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  // get list sleep
  Future<List<SleepModel>> getSleepList() async {
    final sleepList = <SleepModel>[];
    final sleepRef = _db.collection("sleeps");
    final querySnapshot = await sleepRef.get();
    for(var docSnapshot in querySnapshot.docs){
      final sleep = SleepModel.fromShapshot(docSnapshot);
      sleepList.add(sleep);
    }
    return sleepList;
  }
}