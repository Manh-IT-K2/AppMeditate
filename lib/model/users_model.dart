import 'package:cloud_firestore/cloud_firestore.dart';
class UsersModel {
  final String? id;
  final String userName;
  final String passWord;
  final String? fullName;
  final String? email;
  final String? phone;
  late final String? gender;
  final String? birtDay;
  final String? joinDay;
  final int statusChageUser;
  final String ? image;
  final bool typeImage;
  final bool? dowloadCellular;
  final bool? doNotDisturb;
  final String? reminderTime;

  UsersModel({
    this.id, 
    required this.userName, 
    required this.passWord,
    required this.statusChageUser,
    required this.typeImage,
    this.fullName, 
    this.email, 
    this.phone, 
    this.gender, 
    this.birtDay,
    this.joinDay,
    this.image,
    this.dowloadCellular,
    this.doNotDisturb,
    this.reminderTime,

  });
  // : id = id ?? const Uuid().v4();
// chuyển đổi một đối tượng thành một chuỗi JSON. -- // convert an object to a JSON string.
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userName": userName,
      "passWord": passWord,
      "fullName": fullName,
      "email": email,
      "phone": phone,
      "gender": gender,
      "birtDay": birtDay,
      "joinDay": joinDay,
      "statusChageUser": statusChageUser,
      "image": image,
      "typeImage": typeImage,
      "dowloadCellular": dowloadCellular,
      "doNotDisturb": doNotDisturb,
      "reminderTime": reminderTime,
    };
  }

  // Step 1 - Map User fetched from Firebase to Usermodel
  factory UsersModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) {
      throw Exception('Data is null !');
    }
    return UsersModel(
        id: data["id"],
        userName: data["userName"],
        passWord: data["passWord"] ?? "",
        fullName: data["fullName"],
        email: data["email"],
        phone: data["phone"],
        gender: data["gender"],
        birtDay: data["birtDay"],
        joinDay: data["joinDay"],
        statusChageUser: data["statusChageUser"],
        image: data["image"],
        typeImage: data["typeImage"] ?? "",
        dowloadCellular: data["dowloadCellular"],
        doNotDisturb: data["doNotDisturb"],
        reminderTime: data["reminderTime"],);
  }
}
