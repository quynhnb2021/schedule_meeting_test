// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ScheduleResponse _$$_ScheduleResponseFromJson(Map<String, dynamic> json) =>
    _$_ScheduleResponse(
      authorName: json['authorName'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      imgUrl: json['imgUrl'] as String? ?? '',
      title: json['title'] as String? ?? '',
      type: json['type'] as String? ?? '',
    );

Map<String, dynamic> _$$_ScheduleResponseToJson(_$_ScheduleResponse instance) =>
    <String, dynamic>{
      'authorName': instance.authorName,
      'desc': instance.desc,
      'imgUrl': instance.imgUrl,
      'title': instance.title,
      'type': instance.type,
    };
