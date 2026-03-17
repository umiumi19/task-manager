// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Schedule _$ScheduleFromJson(Map<String, dynamic> json) => _Schedule(
  id: json['id'] as String,
  userId: json['userId'] as String,
  todoId: json['todoId'] as String?,
  title: json['title'] as String,
  memo: json['memo'] as String?,
  startAt: DateTime.parse(json['startAt'] as String),
  endAt: const LocalDateTimeConverter().fromJson(json['endAt'] as String?),
  location: json['location'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ScheduleToJson(_Schedule instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'todoId': instance.todoId,
  'title': instance.title,
  'memo': instance.memo,
  'startAt': instance.startAt.toIso8601String(),
  'endAt': const LocalDateTimeConverter().toJson(instance.endAt),
  'location': instance.location,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
