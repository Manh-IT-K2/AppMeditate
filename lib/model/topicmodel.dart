
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'topicmodel.freezed.dart';
part 'topicmodel.g.dart';

@freezed
class Topic with _$Topic  {
  const factory Topic({
    required String title,
    required String thumbnail,
    required String color,
    required String titleColor,

  }) = _Topic;
  factory Topic.fromJson(Map<String, Object?> json) => _$TopicFromJson(json);
}
extension GetBgColor on Topic{
  Color get bgColor => Color(int.parse(color));// ép kiểu
  Color get textColor => Color(int.parse(titleColor));

}