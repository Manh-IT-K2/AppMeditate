
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'sleepmodel.freezed.dart';
part 'sleepmodel.g.dart';
//flutter pub run build_runner build --delete-conflicting-outputs
@freezed
class Sleep with _$Sleep  {
  const factory Sleep({
    required String title,
    required String thumbnail,
    required String color,
    required String titleColor,
    required String timesleep,

  }) = _Sleep;
  factory Sleep.fromJson(Map<String, Object?> json) => _$SleepFromJson(json);
}
extension GetBgColor on Sleep{
  Color get bgColor => Color(int.parse(color));// ép kiểu
  Color get textColor => Color(int.parse(titleColor));

}