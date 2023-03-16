// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meditatemodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Meditate _$MeditateFromJson(Map<String, dynamic> json) {
  return _Meditate.fromJson(json);
}

/// @nodoc
mixin _$Meditate {
  String get title => throw _privateConstructorUsedError;
  String get thumbnail => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  String get titleColor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MeditateCopyWith<Meditate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeditateCopyWith<$Res> {
  factory $MeditateCopyWith(Meditate value, $Res Function(Meditate) then) =
      _$MeditateCopyWithImpl<$Res, Meditate>;
  @useResult
  $Res call({String title, String thumbnail, String color, String titleColor});
}

/// @nodoc
class _$MeditateCopyWithImpl<$Res, $Val extends Meditate>
    implements $MeditateCopyWith<$Res> {
  _$MeditateCopyWithImpl(this._value, this._then);

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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MeditateCopyWith<$Res> implements $MeditateCopyWith<$Res> {
  factory _$$_MeditateCopyWith(
          _$_Meditate value, $Res Function(_$_Meditate) then) =
      __$$_MeditateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String thumbnail, String color, String titleColor});
}

/// @nodoc
class __$$_MeditateCopyWithImpl<$Res>
    extends _$MeditateCopyWithImpl<$Res, _$_Meditate>
    implements _$$_MeditateCopyWith<$Res> {
  __$$_MeditateCopyWithImpl(
      _$_Meditate _value, $Res Function(_$_Meditate) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? thumbnail = null,
    Object? color = null,
    Object? titleColor = null,
  }) {
    return _then(_$_Meditate(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Meditate with DiagnosticableTreeMixin implements _Meditate {
  const _$_Meditate(
      {required this.title,
      required this.thumbnail,
      required this.color,
      required this.titleColor});

  factory _$_Meditate.fromJson(Map<String, dynamic> json) =>
      _$$_MeditateFromJson(json);

  @override
  final String title;
  @override
  final String thumbnail;
  @override
  final String color;
  @override
  final String titleColor;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Meditate(title: $title, thumbnail: $thumbnail, color: $color, titleColor: $titleColor)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Meditate'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('thumbnail', thumbnail))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('titleColor', titleColor));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Meditate &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.titleColor, titleColor) ||
                other.titleColor == titleColor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, thumbnail, color, titleColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MeditateCopyWith<_$_Meditate> get copyWith =>
      __$$_MeditateCopyWithImpl<_$_Meditate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MeditateToJson(
      this,
    );
  }
}

abstract class _Meditate implements Meditate {
  const factory _Meditate(
      {required final String title,
      required final String thumbnail,
      required final String color,
      required final String titleColor}) = _$_Meditate;

  factory _Meditate.fromJson(Map<String, dynamic> json) = _$_Meditate.fromJson;

  @override
  String get title;
  @override
  String get thumbnail;
  @override
  String get color;
  @override
  String get titleColor;
  @override
  @JsonKey(ignore: true)
  _$$_MeditateCopyWith<_$_Meditate> get copyWith =>
      throw _privateConstructorUsedError;
}
