import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../common/models/field.dart';
import '../../../application/schedules_providers.dart';
import '../../../domain/schedule.dart';

part 'edit_schedule_controller.freezed.dart';

@freezed
abstract class EditScheduleState with _$EditScheduleState {
  const factory EditScheduleState({
    @Default(Field(value: '')) Field<String> title,
    String? memo,
    @Default(Field(value: null)) Field<DateTime?> startAt,
    DateTime? endAt,
    String? location,

    Schedule? previousSchedule,

    @Default(AsyncData<void>(null)) AsyncValue<void> asyncValue,
  }) = _EditScheduleState;

  const EditScheduleState._();

  bool get isValid =>
      title.isValid &&
      startAt.isValid &&
      (endAt == null ||
          startAt.value == null ||
          endAt!.isAfter(startAt.value!));

  bool get canAdd => previousSchedule == null && isValid;

  bool get canUpdate =>
      previousSchedule != null &&
      isValid &&
      (previousSchedule!.title != title.value ||
          previousSchedule!.memo != memo ||
          previousSchedule!.startAt != startAt.value ||
          previousSchedule!.endAt != endAt ||
          previousSchedule!.location != location);
}

class EditScheduleController
    extends AutoDisposeFamilyNotifier<EditScheduleState, EditScheduleState> {
  @override
  EditScheduleState build(EditScheduleState initialState) => initialState;

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

  void setStartAt(DateTime? value) {
    state = state.copyWith(
      startAt: state.startAt.copyWith(
        value: value,
        isValid: value != null,
        errorMessage: value == null ? '必須項目です' : null,
      ),
    );
    if (state.endAt != null &&
        state.startAt.value != null &&
        state.endAt!.isBefore(state.startAt.value!)) {
      state = state.copyWith(endAt: null);
    }
  }

  void setEndAt(DateTime? value) {
    state = state.copyWith(endAt: value);
  }

  void setLocation(String? value) {
    state = state.copyWith(location: (value?.isEmpty ?? true) ? null : value);
  }

  Future<bool> addSchedule() async {
    if (!state.isValid || state.startAt.value == null) {
      throw AssertionError('State is not valid');
    }

    state = state.copyWith(asyncValue: const AsyncLoading());
    state = state.copyWith(
      asyncValue: await AsyncValue.guard(
        () => ref
            .read(schedulesRepositoryProvider)
            .create(
              title: state.title.value,
              startAt: state.startAt.value!,
              memo: state.memo,
              endAt: state.endAt,
              location: state.location,
            ),
      ),
    );

    if (state.asyncValue.hasError) return false;
    _invalidateProviders();
    return !state.asyncValue.hasError;
  }

  Future<bool> updateSchedule() async {
    if (!state.isValid ||
        state.previousSchedule == null ||
        state.startAt.value == null) {
      throw AssertionError('State is not valid');
    }

    state = state.copyWith(asyncValue: const AsyncLoading());
    state = state.copyWith(
      asyncValue: await AsyncValue.guard(
        () => ref
            .read(schedulesRepositoryProvider)
            .update(
              state.previousSchedule!.id,
              title: state.title.value,
              memo: state.memo,
              startAt: state.startAt.value,
              endAt: state.endAt,
              location: state.location,
              todoId: state.previousSchedule!.todoId,
            ),
      ),
    );

    if (state.asyncValue.hasError) return false;
    _invalidateProviders();
    return !state.asyncValue.hasError;
  }

  void _invalidateProviders() {
    ref.invalidate(scheduleListProvider);
  }

  Future<bool> deleteSchedule() async {
    if (state.previousSchedule == null) {
      throw AssertionError('State is not valid');
    }

    state = state.copyWith(asyncValue: const AsyncLoading());
    state = state.copyWith(
      asyncValue: await AsyncValue.guard(
        () => ref
            .read(schedulesRepositoryProvider)
            .delete(state.previousSchedule!.id),
      ),
    );
    if (state.asyncValue.hasError) return false;
    _invalidateProviders();
    return !state.asyncValue.hasError;
  }
}

final editScheduleControllerProvider = NotifierProvider.autoDispose
    .family<EditScheduleController, EditScheduleState, EditScheduleState>(
      EditScheduleController.new,
    );
