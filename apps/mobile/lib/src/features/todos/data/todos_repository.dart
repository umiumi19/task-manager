import 'package:dio/dio.dart';
import '../domain/todo.dart';

class TodosRepository {
  TodosRepository(this._dio);

  final Dio _dio;

  static const _path = '/todos';

  /// 一覧取得。includeDone: true で完了含む、false で未完了のみ。
  Future<List<Todo>> list({bool includeDone = true}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      _path,
      queryParameters: {'includeDone': includeDone.toString()},
    );
    final items = response.data!['items'] as List<dynamic>;
    return items.map((e) => Todo.fromJson(e as Map<String, dynamic>)).toList();
  }

  /// 作成。
  Future<Todo> create({
    required String title,
    String? memo,
    DateTime? dueAt,
    int? priority,
    int? estimatedMinutes,
  }) async {
    final body = <String, dynamic>{
      'title': title,
      if (memo != null) 'memo': memo,
      if (dueAt != null) 'dueAt': dueAt.toUtc().toIso8601String(),
      if (priority != null) 'priority': priority,
      if (estimatedMinutes != null) 'estimatedMinutes': estimatedMinutes,
    };
    final response = await _dio.post<Map<String, dynamic>>(_path, data: body);
    return Todo.fromJson(response.data!);
  }

  /// 更新。
  Future<Todo> update(
    String id, {
    String? title,
    String? memo,
    DateTime? dueAt,
    bool? isDone,
    int? priority,
    int? estimatedMinutes,
  }) async {
    final body = <String, dynamic>{
      if (title != null) 'title': title,
      if (memo != null) 'memo': memo,
      if (dueAt != null) 'dueAt': dueAt.toUtc().toIso8601String(),
      if (isDone != null) 'isDone': isDone,
      if (priority != null) 'priority': priority,
      if (estimatedMinutes != null) 'estimatedMinutes': estimatedMinutes,
    };
    final response = await _dio.patch<Map<String, dynamic>>(
      '$_path/$id',
      data: body,
    );
    return Todo.fromJson(response.data!);
  }

  /// 削除。
  Future<void> delete(String id) async {
    await _dio.delete<void>('$_path/$id');
  }
}
