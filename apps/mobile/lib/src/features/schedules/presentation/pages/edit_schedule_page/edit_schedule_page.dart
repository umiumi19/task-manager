import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/models/field.dart';
import '../../../../../common/theme/app_colors.dart';
import '../../../../../common/theme/app_text_styles.dart';
import '../../../../../common/widgets/custom_app_bar.dart';
import '../../../../../common/widgets/form_widget_with_title.dart';
import '../../../../../common/widgets/form_body.dart';
import '../../../../../common/form_fields/custom_text_field.dart';
import '../../../../../common/form_fields/date_time_select_field.dart';
import '../../../../../common/utils/show_alert_dialog.dart';
import '../../../../../common/utils/show_custom_snack_bar.dart';
import '../../../../../common/widgets/custom_icon_button.dart';
import '../../../../../common/widgets/custom_loading.dart';
import '../../../../../common/widgets/primary_button.dart';
import '../../../domain/schedule.dart';
import 'edit_schedule_controller.dart';

/// 予定追加・編集ページ。schedule == null のとき追加、非 null のとき編集。
class EditSchedulePage extends ConsumerWidget {
  const EditSchedulePage({this.schedule, super.key});

  final Schedule? schedule;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final EditScheduleState initialState;

    if (schedule != null) {
      initialState = EditScheduleState(
        title: Field(value: schedule!.title, isValid: true),
        memo: schedule!.memo,
        startAt: Field(value: schedule!.startAt, isValid: true),
        endAt: schedule!.endAt,
        location: schedule!.location,
        previousSchedule: schedule,
      );
    } else {
      initialState = EditScheduleState(
        title: const Field(value: '', isValid: false),
        startAt: Field(value: DateTime.now(), isValid: true),
      );
    }

    return _Body(initialState: initialState, schedule: schedule);
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.initialState, required this.schedule});

  final EditScheduleState initialState;
  final Schedule? schedule;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(
      editScheduleControllerProvider(
        initialState,
      ).select((state) => state.asyncValue.isLoading),
    );
    return FormBody(
      appBar: CustomAppBar(
        title: schedule != null ? '予定を編集' : '予定を追加',
        actions: schedule != null
            ? [_DeleteButton(initialState: initialState, isLoading: isLoading)]
            : null,
        isLoading: isLoading,
      ),
      formWidgets: [
        _EditTitle(initialState: initialState),
        _EditStartAt(initialState: initialState),
        _EditEndAt(initialState: initialState),
        _EditMemo(initialState: initialState),
        _EditLocation(initialState: initialState),
      ],
      bottomButton: schedule != null
          ? _UpdateButton(initialState: initialState, isLoading: isLoading)
          : _AddButton(initialState: initialState, isLoading: isLoading),
      isLoading: isLoading,
    );
  }
}

class _EditTitle extends ConsumerStatefulWidget {
  const _EditTitle({required this.initialState});

  final EditScheduleState initialState;

  @override
  ConsumerState<_EditTitle> createState() => _EditTitleState();
}

class _EditTitleState extends ConsumerState<_EditTitle> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref
          .read(editScheduleControllerProvider(widget.initialState))
          .title
          .value,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = ref.watch(
      editScheduleControllerProvider(
        widget.initialState,
      ).select((state) => state.title.value),
    );
    if (_controller.text != title) {
      _controller.text = title;
      _controller.selection = TextSelection.collapsed(offset: title.length);
    }
    final errorMessage = ref.watch(
      editScheduleControllerProvider(
        widget.initialState,
      ).select((state) => state.title.errorMessage),
    );
    return FormWidgetWithTitle(
      title: 'タイトル',
      topRightWidget: Text(
        '${_controller.text.length}/255',
        style: context.textStyles.labelSmallSemibold.withSubtleTextColor(
          context,
        ),
      ),
      isRequired: true,
      child: CustomTextField(
        hintText: 'タイトルを入力',
        maxLength: 255,
        controller: _controller,
        errorMessage: errorMessage,
        onChanged: (value) => ref
            .read(editScheduleControllerProvider(widget.initialState).notifier)
            .setTitle(value),
      ),
    );
  }
}

class _EditStartAt extends ConsumerWidget {
  const _EditStartAt({required this.initialState});

  final EditScheduleState initialState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startAt = ref.watch(
      editScheduleControllerProvider(
        initialState,
      ).select((state) => state.startAt.value),
    );
    final errorMessage = ref.watch(
      editScheduleControllerProvider(
        initialState,
      ).select((state) => state.startAt.errorMessage),
    );
    return FormWidgetWithTitle(
      title: '開始日時',
      isRequired: true,
      child: DateTimeSelectField(
        value: startAt,
        title: '開始日時',
        errorMessage: errorMessage,
        onChanged: (value) => ref
            .read(editScheduleControllerProvider(initialState).notifier)
            .setStartAt(value),
      ),
    );
  }
}

class _EditEndAt extends ConsumerWidget {
  const _EditEndAt({required this.initialState});

  final EditScheduleState initialState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final endAt = ref.watch(
      editScheduleControllerProvider(
        initialState,
      ).select((state) => state.endAt),
    );
    return FormWidgetWithTitle(
      title: '終了日時',
      isRequired: false,
      child: DateTimeSelectField(
        value: endAt,
        title: '終了日時',
        errorMessage: null,
        onChanged: (value) => ref
            .read(editScheduleControllerProvider(initialState).notifier)
            .setEndAt(value),
      ),
    );
  }
}

class _EditMemo extends ConsumerStatefulWidget {
  const _EditMemo({required this.initialState});

  final EditScheduleState initialState;

  @override
  ConsumerState<_EditMemo> createState() => _EditMemoState();
}

class _EditMemoState extends ConsumerState<_EditMemo> {
  late final TextEditingController _controller;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    final memo =
        ref.read(editScheduleControllerProvider(widget.initialState)).memo ??
        '';
    _controller = TextEditingController(text: memo);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final memo = ref.watch(
      editScheduleControllerProvider(
        widget.initialState,
      ).select((state) => state.memo),
    );
    if (_controller.text != (memo ?? '')) {
      _controller.text = memo ?? '';
      _controller.selection = TextSelection.collapsed(
        offset: _controller.text.length,
      );
    }
    return FormWidgetWithTitle(
      title: 'メモ',
      isRequired: false,
      topRightWidget: Text(
        '${_controller.text.length}/2000',
        style: context.textStyles.labelSmallSemibold.withSubtleTextColor(
          context,
        ),
      ),
      child: Scrollbar(
        controller: _scrollController,
        child: CustomTextField(
          maxLength: 2000,
          controller: _controller,
          hintText: 'メモを入力',
          maxLines: 5,
          minLines: 3,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          scrollController: _scrollController,
          onChanged: (value) => ref
              .read(
                editScheduleControllerProvider(widget.initialState).notifier,
              )
              .setMemo(value.isEmpty ? null : value),
        ),
      ),
    );
  }
}

class _EditLocation extends ConsumerStatefulWidget {
  const _EditLocation({required this.initialState});

  final EditScheduleState initialState;

  @override
  ConsumerState<_EditLocation> createState() => _EditLocationState();
}

class _EditLocationState extends ConsumerState<_EditLocation> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text:
          ref
              .read(editScheduleControllerProvider(widget.initialState))
              .location ??
          '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(
      editScheduleControllerProvider(
        widget.initialState,
      ).select((state) => state.location),
    );
    if (_controller.text != (location ?? '')) {
      _controller.text = location ?? '';
      _controller.selection = TextSelection.collapsed(
        offset: _controller.text.length,
      );
    }
    return FormWidgetWithTitle(
      title: '場所',
      isRequired: false,
      child: CustomTextField(
        hintText: '場所を入力',
        maxLength: 255,
        controller: _controller,
        onChanged: (value) => ref
            .read(editScheduleControllerProvider(widget.initialState).notifier)
            .setLocation(value.isEmpty ? null : value),
      ),
    );
  }
}

class _UpdateButton extends ConsumerWidget {
  const _UpdateButton({required this.initialState, required this.isLoading});

  final EditScheduleState initialState;
  final bool isLoading;

  Future<void> _onPressed(BuildContext context, WidgetRef ref) async {
    final confirmUpdate = await showAlertDialog(
      context: context,
      title: '予定更新',
      content: '予定を更新しますか？',
      defaultActionText: '更新',
      cancelActionText: 'キャンセル',
    );
    if (!(confirmUpdate ?? false)) return;

    if (!context.mounted) return;
    final isSuccessful = await ref
        .read(editScheduleControllerProvider(initialState).notifier)
        .updateSchedule();

    showCustomSnackBar(
      successMessage: '予定を更新しました',
      failMessage: '予定の更新に失敗しました',
      isSuccessful: isSuccessful,
    );

    if (isSuccessful && context.mounted) {
      context.pop(true);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canUpdate = ref.watch(
      editScheduleControllerProvider(
        initialState,
      ).select((state) => state.canUpdate),
    );
    return PrimaryButton(
      text: '更新',
      enabled: canUpdate,
      onPressed: () => _onPressed(context, ref),
      isLoading: isLoading,
    );
  }
}

class _AddButton extends ConsumerWidget {
  const _AddButton({required this.initialState, required this.isLoading});

  final EditScheduleState initialState;
  final bool isLoading;

  Future<void> _onPressed(BuildContext context, WidgetRef ref) async {
    final confirmAdd = await showAlertDialog(
      context: context,
      title: '予定作成',
      content: '予定を追加しますか？',
      defaultActionText: '作成',
      cancelActionText: 'キャンセル',
    );
    if (!(confirmAdd ?? false)) return;

    if (!context.mounted) return;
    final isSuccessful = await ref
        .read(editScheduleControllerProvider(initialState).notifier)
        .addSchedule();

    showCustomSnackBar(
      successMessage: '予定を作成しました',
      failMessage: '予定の作成に失敗しました',
      isSuccessful: isSuccessful,
    );

    if (isSuccessful && context.mounted) {
      context.pop(true);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canAdd = ref.watch(
      editScheduleControllerProvider(
        initialState,
      ).select((state) => state.canAdd),
    );
    return PrimaryButton(
      text: '作成',
      enabled: canAdd,
      onPressed: () => _onPressed(context, ref),
      isLoading: isLoading,
    );
  }
}

class _DeleteButton extends ConsumerWidget {
  const _DeleteButton({required this.initialState, required this.isLoading});

  final EditScheduleState initialState;
  final bool isLoading;

  Future<void> _onPressed(BuildContext context, WidgetRef ref) async {
    final confirmDelete = await showAlertDialog(
      context: context,
      title: '予定削除',
      content: 'この予定を削除しますか？',
      defaultActionText: '削除',
      defaultActionTextColor: context.appColors.pointOrange,
      cancelActionText: 'キャンセル',
    );
    if (!(confirmDelete ?? false)) return;

    if (!context.mounted) return;
    final isSuccessful = await ref
        .read(editScheduleControllerProvider(initialState).notifier)
        .deleteSchedule();

    showCustomSnackBar(
      successMessage: '予定を削除しました',
      failMessage: '予定の削除に失敗しました。',
      isSuccessful: isSuccessful,
    );

    if (isSuccessful && context.mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _onPressed(context, ref),
      child: isLoading
          ? CustomLoading(loadingColor: context.appColors.primary)
          : CustomIconButton(
              icon: Icons.delete_outlined,
              color: context.appColors.pointOrange,
            ),
    );
  }
}
