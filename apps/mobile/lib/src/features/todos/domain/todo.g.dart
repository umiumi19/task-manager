// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Todo _$TodoFromJson(Map<String, dynamic> json) => _Todo(
  id: json['id'] as String,
  userId: json['userId'] as String,
  title: json['title'] as String,
  memo: json['memo'] as String?,
  dueAt: const LocalDateTimeConverter().fromJson(json['dueAt'] as String?),
  isDone: json['isDone'] as bool,
  priority: (json['priority'] as num?)?.toInt() ?? 2,
  estimatedMinutes: (json['estimatedMinutes'] as num?)?.toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$TodoToJson(_Todo instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'title': instance.title,
  'memo': instance.memo,
  'dueAt': const LocalDateTimeConverter().toJson(instance.dueAt),
  'isDone': instance.isDone,
  'priority': instance.priority,
  'estimatedMinutes': instance.estimatedMinutes,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
