// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sleepmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Sleep _$SleepFromJson(Map<String, dynamic> json) {
  return _Sleep.fromJson(json);
}

/// @nodoc
mixin _$Sleep {
  String get title => throw _privateConstructorUsedError;
  String get thumbnail => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  String get titleColor => throw _privateConstructorUsedError;
  String get timesleep => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SleepCopyWith<Sleep> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SleepCopyWith<$Res> {
  factory $SleepCopyWith(Sleep value, $Res Function(Sleep) then) =
      _$SleepCopyWithImpl<$Res, Sleep>;
  @useResult
  $Res call(
      {String title,
      String thumbnail,
      String color,
      String titleColor,
      String timesleep});
}

/// @nodoc
class _$SleepCopyWithImpl<$Res, $Val extends Sleep>
    implements $SleepCopyWith<$Res> {
  _$SleepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? thumbnail = null,
    Object? color = null,
    Object? titleColor = null,
    Object? timesleep = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      titleColor: null == titleColor
          ? _value.titleColor
          : titleColor // ignore: cast_nullable_to_non_nullable
              as String,
      timesleep: null == timesleep
          ? _value.timesleep
          : timesleep // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SleepCopyWith<$Res> implements $SleepCopyWith<$Res> {
  factory _$$_SleepCopyWith(_$_Sleep value, $Res Function(_$_Sleep) then) =
      __$$_SleepCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String thumbnail,
      String color,
      String titleColor,
      String timesleep});
}

/// @nodoc
class __$$_SleepCopyWithImpl<$Res> extends _$SleepCopyWithImpl<$Res, _$_Sleep>
    implements _$$_SleepCopyWith<$Res> {
  __$$_SleepCopyWithImpl(_$_Sleep _value, $Res Function(_$_Sleep) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? thumbnail = null,
    Object? color = null,
    Object? titleColor = null,
    Object? timesleep = null,
  }) {
    return _then(_$_Sleep(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      titleColor: null == titleColor
          ? _value.titleColor
          : titleColor // ignore: cast_nullable_to_non_nullable
              as String,
      timesleep: null == timesleep
          ? _value.timesleep
          : timesleep // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Sleep with DiagnosticableTreeMixin implements _Sleep {
  const _$_Sleep(
      {required this.title,
      required this.thumbnail,
      required this.color,
      required this.titleColor,
      required this.timesleep});

  factory _$_Sleep.fromJson(Map<String, dynamic> json) =>
      _$$_SleepFromJson(json);

  @override
  final String title;
  @override
  final String thumbnail;
  @override
  final String color;
  @override
  final String titleColor;
  @override
  final String timesleep;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Sleep(title: $title, thumbnail: $thumbnail, color: $color, titleColor: $titleColor, timesleep: $timesleep)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Sleep'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('thumbnail', thumbnail))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('titleColor', titleColor))
      ..add(DiagnosticsProperty('timesleep', timesleep));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Sleep &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.titleColor, titleColor) ||
                other.titleColor == titleColor) &&
            (identical(other.timesleep, timesleep) ||
                other.timesleep == timesleep));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, thumbnail, color, titleColor, timesleep);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SleepCopyWith<_$_Sleep> get copyWith =>
      __$$_SleepCopyWithImpl<_$_Sleep>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SleepToJson(
      this,
    );
  }
}

abstract class _Sleep implements Sleep {
  const factory _Sleep(
      {required final String title,
      required final String thumbnail,
      required final String color,
      required final String titleColor,
      required final String timesleep}) = _$_Sleep;

  factory _Sleep.fromJson(Map<String, dynamic> json) = _$_Sleep.fromJson;

  @override
  String get title;
  @override
  String get thumbnail;
  @override
  String get color;
  @override
  String get titleColor;
  @override
  String get timesleep;
  @override
  @JsonKey(ignore: true)
  _$$_SleepCopyWith<_$_Sleep> get copyWith =>
      throw _privateConstructorUsedError;
}
