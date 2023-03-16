
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'meditatemodel.freezed.dart';
part 'meditatemodel.g.dart';

@freezed
class Meditate with _$Meditate  {
  const factory Meditate({
    required String title,
    required String thumbnail,
    required String color,
    required String titleColor,

  }) = _Meditate;
  factory Meditate.fromJson(Map<String, Object?> json) => _$MeditateFromJson(json);
}
extension GetBgColor on Meditate{
  Color get bgColor => Color(int.parse(color));// ép kiểu
  Color get textColor => Color(int.parse(titleColor));

}