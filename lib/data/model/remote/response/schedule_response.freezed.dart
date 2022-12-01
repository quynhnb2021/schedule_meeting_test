// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'schedule_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ScheduleResponse _$ScheduleResponseFromJson(Map<String, dynamic> json) {
  return _ScheduleResponse.fromJson(json);
}

/// @nodoc
mixin _$ScheduleResponse {
  @JsonKey(name: 'authorName')
  String get authorName => throw _privateConstructorUsedError;
  @JsonKey(name: 'desc')
  String get desc => throw _privateConstructorUsedError;
  @JsonKey(name: 'imgUrl')
  String get imgUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScheduleResponseCopyWith<ScheduleResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleResponseCopyWith<$Res> {
  factory $ScheduleResponseCopyWith(
          ScheduleResponse value, $Res Function(ScheduleResponse) then) =
      _$ScheduleResponseCopyWithImpl<$Res, ScheduleResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'authorName') String authorName,
      @JsonKey(name: 'desc') String desc,
      @JsonKey(name: 'imgUrl') String imgUrl,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'type') String type});
}

/// @nodoc
class _$ScheduleResponseCopyWithImpl<$Res, $Val extends ScheduleResponse>
    implements $ScheduleResponseCopyWith<$Res> {
  _$ScheduleResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authorName = null,
    Object? desc = null,
    Object? imgUrl = null,
    Object? title = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      imgUrl: null == imgUrl
          ? _value.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ScheduleResponseCopyWith<$Res>
    implements $ScheduleResponseCopyWith<$Res> {
  factory _$$_ScheduleResponseCopyWith(
          _$_ScheduleResponse value, $Res Function(_$_ScheduleResponse) then) =
      __$$_ScheduleResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'authorName') String authorName,
      @JsonKey(name: 'desc') String desc,
      @JsonKey(name: 'imgUrl') String imgUrl,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'type') String type});
}

/// @nodoc
class __$$_ScheduleResponseCopyWithImpl<$Res>
    extends _$ScheduleResponseCopyWithImpl<$Res, _$_ScheduleResponse>
    implements _$$_ScheduleResponseCopyWith<$Res> {
  __$$_ScheduleResponseCopyWithImpl(
      _$_ScheduleResponse _value, $Res Function(_$_ScheduleResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authorName = null,
    Object? desc = null,
    Object? imgUrl = null,
    Object? title = null,
    Object? type = null,
  }) {
    return _then(_$_ScheduleResponse(
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      imgUrl: null == imgUrl
          ? _value.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScheduleResponse implements _ScheduleResponse {
  const _$_ScheduleResponse(
      {@JsonKey(name: 'authorName') this.authorName = '',
      @JsonKey(name: 'desc') this.desc = '',
      @JsonKey(name: 'imgUrl') this.imgUrl = '',
      @JsonKey(name: 'title') this.title = '',
      @JsonKey(name: 'type') this.type = ''});

  factory _$_ScheduleResponse.fromJson(Map<String, dynamic> json) =>
      _$$_ScheduleResponseFromJson(json);

  @override
  @JsonKey(name: 'authorName')
  final String authorName;
  @override
  @JsonKey(name: 'desc')
  final String desc;
  @override
  @JsonKey(name: 'imgUrl')
  final String imgUrl;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'type')
  final String type;

  @override
  String toString() {
    return 'ScheduleResponse(authorName: $authorName, desc: $desc, imgUrl: $imgUrl, title: $title, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScheduleResponse &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.imgUrl, imgUrl) || other.imgUrl == imgUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, authorName, desc, imgUrl, title, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ScheduleResponseCopyWith<_$_ScheduleResponse> get copyWith =>
      __$$_ScheduleResponseCopyWithImpl<_$_ScheduleResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScheduleResponseToJson(
      this,
    );
  }
}

abstract class _ScheduleResponse implements ScheduleResponse {
  const factory _ScheduleResponse(
      {@JsonKey(name: 'authorName') final String authorName,
      @JsonKey(name: 'desc') final String desc,
      @JsonKey(name: 'imgUrl') final String imgUrl,
      @JsonKey(name: 'title') final String title,
      @JsonKey(name: 'type') final String type}) = _$_ScheduleResponse;

  factory _ScheduleResponse.fromJson(Map<String, dynamic> json) =
      _$_ScheduleResponse.fromJson;

  @override
  @JsonKey(name: 'authorName')
  String get authorName;
  @override
  @JsonKey(name: 'desc')
  String get desc;
  @override
  @JsonKey(name: 'imgUrl')
  String get imgUrl;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'type')
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$_ScheduleResponseCopyWith<_$_ScheduleResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
