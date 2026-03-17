import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/utils/local_date_time_converter.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String userId,
    required String title,
    String? memo,
    @LocalDateTimeConverter() DateTime? dueAt,
    required bool isDone,
    @Default(2) int priority,
    int? estimatedMinutes,
    @LocalDateTimeConverter() required DateTime createdAt,
    @LocalDateTimeConverter() required DateTime updatedAt,
  }) = _Todo;

  const Todo._();

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
