// ignore_for_file: depend_on_referenced_packages

import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_response.freezed.dart';
part 'schedule_response.g.dart';

@freezed
class ScheduleResponse with _$ScheduleResponse {
  const factory ScheduleResponse({
    @JsonKey(name: 'authorName') @Default('') String authorName,
    @JsonKey(name: 'desc') @Default('') String desc,
    @JsonKey(name: 'imgUrl') @Default('') String imgUrl,
    @JsonKey(name: 'title') @Default('') String title,
    @JsonKey(name: 'type') @Default('') String type,
  }) = _ScheduleResponse;

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleResponseFromJson(json);
}
