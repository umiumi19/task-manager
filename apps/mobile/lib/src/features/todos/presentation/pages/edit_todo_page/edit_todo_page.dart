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
import '../../../domain/todo.dart';
import 'edit_todo_controller.dart';

/// タスク追加・編集ページ。todo == null のとき追加、非 null のとき編集。
class EditTodoPage extends ConsumerWidget {
  const EditTodoPage({this.todo, super.key});

  final Todo? todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final EditTodoState initialState;

    if (todo != null) {
      initialState = EditTodoState(
        title: Field(value: todo!.title, isValid: true),
        memo: todo!.memo,
        dueAt: Field(value: todo!.dueAt, isValid: true),
        isDone: todo!.isDone,
        previousTodo: todo,
      );
    } else {
      initialState = const EditTodoState(
        title: Field(value: '', isValid: false),
        dueAt: Field(value: null, isValid: true),
      );
    }

    return _Body(initialState: initialState, todo: todo);
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.initialState, required this.todo});

  final EditTodoState initialState;
  final Todo? todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(
      editTodoControllerProvider(
        initialState,
      ).select((state) => state.asyncValue.isLoading),
    );
    return FormBody(
      appBar: CustomAppBar(
        title: todo != null ? 'タスク編集' : 'タスクを追加',
        actions: todo != null
            ? [_DeleteButton(initialState: initialState, isLoading: isLoading)]
            : null,
        isLoading: isLoading,
      ),
      formWidgets: [
        _EditTitle(initialState: initialState),
        _EditDueAt(initialState: initialState),
        _EditMemo(initialState: initialState),
      ],
      bottomButton: todo != null
          ? _UpdateButton(initialState: initialState, isLoading: isLoading)
          : _AddButton(initialState: initialState, isLoading: isLoading),
      isLoading: isLoading,
    );
  }
}

class _EditTitle extends ConsumerStatefulWidget {
  const _EditTitle({required this.initialState});

  final EditTodoState initialState;

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
          .read(editTodoControllerProvider(widget.initialState))
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
      editTodoControllerProvider(
        widget.initialState,
      ).select((state) => state.title.value),
    );
    if (_controller.text != title) {
      _controller.text = title;
      _controller.selection = TextSelection.collapsed(offset: title.length);
    }
    final errorMessage = ref.watch(
      editTodoControllerProvider(
        widget.initialState,
      ).select((state) => state.title.errorMessage),
    );
    return FormWidgetWithTitle(
      title: 'タスク名',
      topRightWidget: Text(
        '${_controller.text.length}/255',
        style: context.textStyles.labelSmallSemibold.withSubtleTextColor(
          context,
        ),
      ),
      isRequired: true,
      child: CustomTextField(
        hintText: 'タスク名を入力',
        maxLength: 255,
        controller: _controller,
        errorMessage: errorMessage,
        onChanged: (value) => ref
            .read(editTodoControllerProvider(widget.initialState).notifier)
            .setTitle(value),
      ),
    );
  }
}

class _EditDueAt extends ConsumerWidget {
  const _EditDueAt({required this.initialState});

  final EditTodoState initialState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dueAt = ref.watch(
      editTodoControllerProvider(
        initialState,
      ).select((state) => state.dueAt.value),
    );
    final errorMessage = ref.watch(
      editTodoControllerProvider(
        initialState,
      ).select((state) => state.dueAt.errorMessage),
    );
    return FormWidgetWithTitle(
      title: '締切',
      isRequired: false,
      child: DateTimeSelectField(
        value: dueAt,
        title: '締切',
        errorMessage: errorMessage,
        onChanged: (value) => ref
            .read(editTodoControllerProvider(initialState).notifier)
            .setDueAt(value),
      ),
    );
  }
}

class _EditMemo extends ConsumerStatefulWidget {
  const _EditMemo({required this.initialState});

  final EditTodoState initialState;

  @override
  ConsumerState<_EditMemo> createState() => _EditMemoState();
}

class _EditMemoState extends ConsumerState<_EditMemo> {
  late final TextEditingController _controller;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    final note =
        ref.read(editTodoControllerProvider(widget.initialState)).memo ?? '';
    _controller = TextEditingController(text: note);
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
    final note = ref.watch(
      editTodoControllerProvider(
        widget.initialState,
      ).select((state) => state.memo),
    );
    if (_controller.text != (note ?? '')) {
      _controller.text = note ?? '';
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
          maxLines: 15,
          minLines: 3,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          scrollController: _scrollController,
          onChanged: (value) => ref
              .read(editTodoControllerProvider(widget.initialState).notifier)
              .setMemo(value.isEmpty ? null : value),
        ),
      ),
    );
  }
}

class _UpdateButton extends ConsumerWidget {
  const _UpdateButton({required this.initialState, required this.isLoading});

  final EditTodoState initialState;
  final bool isLoading;

  Future<void> _onPressed(BuildContext context, WidgetRef ref) async {
    final confirmUpdate = await showAlertDialog(
      context: context,
      title: 'タスク更新',
      content: 'タスクを更新しますか？',
      defaultActionText: '更新',
      cancelActionText: 'キャンセル',
    );
    if (!(confirmUpdate ?? false)) return;

    if (!context.mounted) return;
    final isSuccessful = await ref
        .read(editTodoControllerProvider(initialState).notifier)
        .updateTodo();

    showCustomSnackBar(
      successMessage: 'タスクを更新しました',
      failMessage: 'タスクの更新に失敗しました',
      isSuccessful: isSuccessful,
    );

    if (isSuccessful && context.mounted) {
      context.pop(true);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canUpdate = ref.watch(
      editTodoControllerProvider(
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

  final EditTodoState initialState;
  final bool isLoading;

  Future<void> _onPressed(BuildContext context, WidgetRef ref) async {
    final confirmAdd = await showAlertDialog(
      context: context,
      title: 'タスク作成',
      content: 'タスクを追加しますか？',
      defaultActionText: '作成',
      cancelActionText: 'キャンセル',
    );
    if (!(confirmAdd ?? false)) return;

    if (!context.mounted) return;
    final isSuccessful = await ref
        .read(editTodoControllerProvider(initialState).notifier)
        .addTodo();

    showCustomSnackBar(
      successMessage: 'タスクを作成しました',
      failMessage: 'タスクの作成に失敗しました',
      isSuccessful: isSuccessful,
    );

    if (isSuccessful && context.mounted) {
      context.pop(true);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canAdd = ref.watch(
      editTodoControllerProvider(initialState).select((state) => state.canAdd),
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

  final EditTodoState initialState;
  final bool isLoading;

  Future<void> _onPressed(BuildContext context, WidgetRef ref) async {
    final confirmDelete = await showAlertDialog(
      context: context,
      title: 'タスク削除',
      content: 'このタスクを削除しますか？',
      defaultActionText: '削除',
      defaultActionTextColor: context.appColors.pointOrange,
      cancelActionText: 'キャンセル',
    );
    if (!(confirmDelete ?? false)) return;

    if (!context.mounted) return;
    final isSuccessful = await ref
        .read(editTodoControllerProvider(initialState).notifier)
        .deleteTodo();

    showCustomSnackBar(
      successMessage: 'タスクを削除しました',
      failMessage: 'タスクの削除に失敗しました。',
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
