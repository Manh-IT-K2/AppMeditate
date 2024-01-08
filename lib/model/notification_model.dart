class NotificationModel {
  int? id;
  String? title;
  String? subTitle;
  String? time;

  NotificationModel({
    this.id,
    this.title,
    this.subTitle,
    this.time
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    subTitle = json["subTitle"];
    time = json["time"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["title"] = this.title;
    data["subTitle"] = this.subTitle;
    data["time"] = this.time;
    return data;
  }
}