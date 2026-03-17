import 'package:dio/dio.dart';
import '../domain/schedule.dart';

class SchedulesRepository {
  SchedulesRepository(this._dio);

  final Dio _dio;

  static const _path = '/schedules';

  /// 一覧取得。
  Future<List<Schedule>> list() async {
    final response = await _dio.get<Map<String, dynamic>>(_path);
    final items = response.data!['items'] as List<dynamic>;
    return items
        .map((e) => Schedule.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 作成。
  Future<Schedule> create({
    required String title,
    required DateTime startAt,
    String? memo,
    DateTime? endAt,
    String? location,
    String? todoId,
  }) async {
    final body = <String, dynamic>{
      'title': title,
      'startAt': startAt.toUtc().toIso8601String(),
      if (memo != null) 'memo': memo,
      if (endAt != null) 'endAt': endAt.toUtc().toIso8601String(),
      if (location != null) 'location': location,
      if (todoId != null) 'todoId': todoId,
    };
    final response = await _dio.post<Map<String, dynamic>>(_path, data: body);
    return Schedule.fromJson(response.data!);
  }

  /// 更新。
  Future<Schedule> update(
    String id, {
    String? title,
    String? memo,
    DateTime? startAt,
    DateTime? endAt,
    String? location,
    String? todoId,
  }) async {
    final body = <String, dynamic>{
      if (title != null) 'title': title,
      if (memo != null) 'memo': memo,
      if (startAt != null) 'startAt': startAt.toUtc().toIso8601String(),
      if (endAt != null) 'endAt': endAt.toUtc().toIso8601String(),
      if (location != null) 'location': location,
      if (todoId != null) 'todoId': todoId,
    };
    final response = await _dio.patch<Map<String, dynamic>>(
      '$_path/$id',
      data: body,
    );
    return Schedule.fromJson(response.data!);
  }

  /// 削除。
  Future<void> delete(String id) async {
    await _dio.delete<void>('$_path/$id');
  }
}
