import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/utils/local_date_time_converter.dart';

part 'schedule.freezed.dart';
part 'schedule.g.dart';

@freezed
abstract class Schedule with _$Schedule {
  const factory Schedule({
    required String id,
    required String userId,
    String? todoId,
    required String title,
    String? memo,
    @LocalDateTimeConverter() required DateTime startAt,
    @LocalDateTimeConverter() DateTime? endAt,
    String? location,
    @LocalDateTimeConverter() required DateTime createdAt,
    @LocalDateTimeConverter() required DateTime updatedAt,
  }) = _Schedule;

  const Schedule._();

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
}
