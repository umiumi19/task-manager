import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/todos_providers.dart';
import '../../domain/todo.dart';

/// タイルごとの「表示上の完了状態」を保持。
/// チェック時に一覧を invalidate せず、この state だけ更新して青いチェックで残す。
class TodoListTileState {
  const TodoListTileState({
    required this.todoId,
    required this.isDone,
    this.asyncValue = const AsyncData<void>(null),
  });

  final String todoId;
  final bool isDone;
  final AsyncValue<void> asyncValue;

  TodoListTileState copyWith({
    String? todoId,
    bool? isDone,
    AsyncValue<void>? asyncValue,
  }) {
    return TodoListTileState(
      todoId: todoId ?? this.todoId,
      isDone: isDone ?? this.isDone,
      asyncValue: asyncValue ?? this.asyncValue,
    );
  }

  static TodoListTileState fromTodo(Todo todo) {
    return TodoListTileState(todoId: todo.id, isDone: todo.isDone);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoListTileState &&
          runtimeType == other.runtimeType &&
          todoId == other.todoId;

  @override
  int get hashCode => todoId.hashCode;
}

class TodoListTileNotifier
    extends AutoDisposeFamilyNotifier<TodoListTileState, TodoListTileState> {
  @override
  TodoListTileState build(TodoListTileState arg) => arg;

  /// 完了トグル。API 呼び出し後、ローカル state を更新（一覧は invalidate しない）。
  Future<bool> toggleIsDone() async {
    state = state.copyWith(asyncValue: const AsyncLoading());
    final result = await AsyncValue.guard(
      () => ref
          .read(todosRepositoryProvider)
          .update(state.todoId, isDone: !state.isDone),
    );
    if (result.hasError) {
      state = state.copyWith(asyncValue: result);
      return false;
    }
    state = state.copyWith(
      isDone: !state.isDone,
      asyncValue: const AsyncData(null),
    );
    return true;
  }
}

final todoListTileControllerProvider = NotifierProvider.autoDispose
    .family<TodoListTileNotifier, TodoListTileState, TodoListTileState>(
      TodoListTileNotifier.new,
    );
