// ignore_for_file: depend_on_referenced_packages

import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_response.freezed.dart';
part 'blog_response.g.dart';

@freezed
class ScheduleResponse with _$BlogResponse {
  const factory ScheduleResponse({
    @JsonKey(name: 'authorName') @Default('') String authorName,
    @JsonKey(name: 'desc') @Default('') String desc,
    @JsonKey(name: 'imgUrl') @Default('') String imgUrl,
    @JsonKey(name: 'title') @Default('') String title,
    @JsonKey(name: 'type') @Default('') String type,
  }) = _BlogResponse;

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) =>
      _$BlogResponseFromJson(json);
}
