import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_providers.dart';
import '../data/todos_repository.dart';
import '../domain/todo.dart';

final todosRepositoryProvider = Provider<TodosRepository>((ref) {
  final dio = ref.watch(apiDioProvider);
  return TodosRepository(dio);
});

/// 一覧取得。includeDone で完了含むか。
final todoListProvider = FutureProvider.autoDispose.family<List<Todo>, bool>((
  ref,
  includeDone,
) async {
  final repo = ref.watch(todosRepositoryProvider);
  return repo.list(includeDone: includeDone);
});

/// 期日の近い未完了 ToDo を最大 [limit] 件。dueAt が null は末尾。
final nearestTodosProvider = FutureProvider.autoDispose.family<List<Todo>, int>(
  (ref, limit) async {
    final list = await ref.watch(todoListProvider(false).future);
    final sorted = List<Todo>.from(list)
      ..sort((a, b) {
        if (a.dueAt == null && b.dueAt == null) return 0;
        if (a.dueAt == null) return 1;
        if (b.dueAt == null) return -1;
        return a.dueAt!.compareTo(b.dueAt!);
      });
    return sorted.take(limit).toList();
  },
);
