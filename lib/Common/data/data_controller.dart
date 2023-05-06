import 'package:get/get.dart';

class DataController extends GetxController{
  var musicTitle = "".obs;
  var musicAuthor = "".obs;
  var musicImage = "".obs;
  var musicUrl = "".obs;

  var userName = "".obs;
  setUserName(String value){
    userName.value = value;
  }

  var phone = "".obs;
  setPhone(String value){
    phone.value = value;
  }

  var email = "".obs;
  setEmail(String value){
    email.value = value;
  }
}