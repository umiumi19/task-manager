import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../common/models/field.dart';
import '../../../application/todos_providers.dart';
import '../../../domain/todo.dart';

part 'edit_todo_controller.freezed.dart';

@freezed
abstract class EditTodoState with _$EditTodoState {
  const factory EditTodoState({
    @Default(Field(value: '')) Field<String> title,
    String? memo,
    @Default(Field(value: null)) Field<DateTime?> dueAt,
    @Default(false) bool isDone,

    Todo? previousTodo,

    @Default(AsyncData<void>(null)) AsyncValue<void> asyncValue,
  }) = _EditTodoState;

  const EditTodoState._();

  bool get isValid => title.isValid && dueAt.isValid;

  bool get canAdd => previousTodo == null && isValid;

  bool get canUpdate =>
      previousTodo != null &&
      isValid &&
      (previousTodo!.title != title.value ||
          previousTodo!.memo != memo ||
          previousTodo!.dueAt != dueAt.value ||
          previousTodo!.isDone != isDone);
}

class EditTodoController
    extends AutoDisposeFamilyNotifier<EditTodoState, EditTodoState> {
  @override
  EditTodoState build(EditTodoState initialState) => initialState;

  void setTitle(String value) {
    var field = state.title.copyWith(value: value);
    if (value.isEmpty) {
      field = field.copyWith(isValid: false, errorMessage: '必須項目です');
    } else {
      field = field.copyWith(isValid: true, errorMessage: null);
    }
    state = state.copyWith(title: field);
  }

  void setMemo(String? value) {
    state = state.copyWith(memo: (value?.isEmpty ?? true) ? null : value);
  }

  void setDueAt(DateTime? value) {
    state = state.copyWith(
      dueAt: state.dueAt.copyWith(
        value: value,
        isValid: true,
        errorMessage: null,
      ),
    );
  }

  Future<bool> addTodo() async {
    if (!state.isValid) throw AssertionError('State is not valid');

    state = state.copyWith(asyncValue: const AsyncLoading());
    state = state.copyWith(
      asyncValue: await AsyncValue.guard(
        () => ref
            .read(todosRepositoryProvider)
            .create(
              title: state.title.value,
              memo: state.memo,
              dueAt: state.dueAt.value,
            ),
      ),
    );

    if (state.asyncValue.hasError) return false;
    _invalidateProviders();
    return !state.asyncValue.hasError;
  }

  Future<bool> updateTodo() async {
    if (!state.isValid || state.previousTodo == null) {
      throw AssertionError('State is not valid');
    }

    state = state.copyWith(asyncValue: const AsyncLoading());
    state = state.copyWith(
      asyncValue: await AsyncValue.guard(
        () => ref
            .read(todosRepositoryProvider)
            .update(
              state.previousTodo!.id,
              title: state.title.value,
              memo: state.memo,
              dueAt: state.dueAt.value,
              isDone: state.isDone,
            ),
      ),
    );

    if (state.asyncValue.hasError) return false;
    _invalidateProviders();
    return !state.asyncValue.hasError;
  }

  void _invalidateProviders() {
    ref.invalidate(todoListProvider);
  }

  Future<bool> deleteTodo() async {
    if (state.previousTodo == null) throw AssertionError('State is not valid');

    state = state.copyWith(asyncValue: const AsyncLoading());
    state = state.copyWith(
      asyncValue: await AsyncValue.guard(
        () => ref.read(todosRepositoryProvider).delete(state.previousTodo!.id),
      ),
    );
    if (state.asyncValue.hasError) return false;
    _invalidateProviders();
    return !state.asyncValue.hasError;
  }
}

final editTodoControllerProvider = NotifierProvider.autoDispose
    .family<EditTodoController, EditTodoState, EditTodoState>(
      EditTodoController.new,
    );
