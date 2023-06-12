import 'package:get/get.dart';
import 'package:meditation_app/Repository/topics_repository/topics_repository.dart';
import 'package:meditation_app/model/topics_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopicController extends GetxController {
  static TopicController get instance => Get.find();
  final topicRepo = Get.put(ToppicsRepository());

  // get list topic
  Future<List<TopicsModel>> getTopicList() async{
    return await topicRepo.getTopicList();
  }
  
  // save chose topic
  void saveChoseTopic(String topic) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("topic", topic);
  }

  // get topic save with sharedpreferences
  Future<String> getChoseTopic() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("topic") ?? "";
  }
}