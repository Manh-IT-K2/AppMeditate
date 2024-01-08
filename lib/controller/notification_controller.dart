import 'package:get/get.dart';
import 'package:meditation_app/Repository/sqlite_repository/db_helper.dart';
import 'package:meditation_app/model/notification_model.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();

  @override
  void onReady(){
    super.onReady();
  }

  Future<int> addNotification({NotificationModel? notificationModel}) async {
    return await DBHelper.insert(notificationModel);
  }
  
  var notificationList = <NotificationModel>[].obs;
  // get all the data from table
  void getNotification() async {
    List<Map<String, dynamic>> notifications = await DBHelper.query();
    notificationList.assignAll(notifications.map((data) => new NotificationModel.fromJson(data)).toList());
  }
}