import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../common/constants/app_sizes.dart';
import '../../../../common/theme/app_colors.dart';
import '../../../../common/theme/app_text_styles.dart';
import '../../../../common/widgets/icon_label.dart';
import '../../domain/todo.dart';
import 'todo_list_tile_controller.dart';

/// タスク1件をチェックボックス・タイトル・締切・メモで表示。
/// チェック時は一覧を invalidate せず、タイル用 state だけ更新して青いチェックで残す。
class TodoListTile extends ConsumerWidget {
  const TodoListTile({
    required this.todo,
    required this.onTap,
    super.key,
    this.showCheckbox = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(AppSizes.p8)),
    this.margin = EdgeInsets.zero,
  });

  final Todo todo;
  final VoidCallback onTap;

  /// true のときチェックボックスを表示し、タイル用 controller で完了トグル（一覧は invalidate しない）
  final bool showCheckbox;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry margin;

  Color _getTileColor(BuildContext context, bool isDone) {
    final now = DateTime.now();
    if (isDone) {
      return context.appColors.surface;
    }
    if (todo.dueAt != null && todo.dueAt!.isBefore(now)) {
      return context.appColors.cancelledColor;
    }
    return context.appColors.surface;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!showCheckbox) {
      return _buildTile(
        context,
        isDone: todo.isDone,
        onCheckTap: null,
        isLoading: false,
      );
    }
    final initialState = TodoListTileState.fromTodo(todo);
    final isDone = ref.watch(
      todoListTileControllerProvider(initialState).select((s) => s.isDone),
    );
    final isLoading = ref.watch(
      todoListTileControllerProvider(
        initialState,
      ).select((s) => s.asyncValue.isLoading),
    );
    final notifier = ref.read(
      todoListTileControllerProvider(initialState).notifier,
    );

    return _buildTile(
      context,
      isDone: isDone,
      onCheckTap: () async {
        if (isLoading) return;
        await notifier.toggleIsDone();
      },
      isLoading: isLoading,
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required bool isDone,
    VoidCallback? onCheckTap,
    required bool isLoading,
  }) {
    final dateFormat = DateFormat('yyyy年M月d日(E) HH:mm', 'ja');
    final dueLabel = todo.dueAt != null
        ? dateFormat.format(todo.dueAt!)
        : '未設定';
    final dueColor =
        todo.dueAt != null &&
            todo.dueAt!.isBefore(DateTime.now().add(const Duration(days: 1))) &&
            !isDone
        ? context.appColors.pointOrange
        : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: _getTileColor(context, isDone),
        ),
        child: Row(
          children: [
            if (onCheckTap != null)
              GestureDetector(
                onTap: isLoading ? null : onCheckTap,
                child: Container(
                  color: context.appColors.transparent,
                  padding: const EdgeInsets.all(AppSizes.p16),
                  child: isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: context.appColors.primary,
                          ),
                        )
                      : Icon(
                          isDone
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: isDone
                              ? context.appColors.primary
                              : context.appColors.subtleText,
                          size: 24,
                        ),
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  0,
                  AppSizes.p12,
                  AppSizes.p16,
                  AppSizes.p12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: context.textStyles.labelMediumSemibold
                          .withPrimaryTextColor(context)
                          .copyWith(
                            decoration: isDone
                                ? TextDecoration.lineThrough
                                : null,
                            decorationColor: context.appColors.subtleText,
                          ),
                    ),
                    gapH8,
                    IconLabel(
                      icon: Icons.date_range_outlined,
                      label: dueLabel,
                      labelColor: dueColor,
                    ),
                    if (todo.memo != null && todo.memo!.isNotEmpty) ...[
                      gapH4,
                      _DisplayNote(text: todo.memo!),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// メモを1行で表示。長い場合は省略。
class _DisplayNote extends StatelessWidget {
  const _DisplayNote({required this.text});

  final String text;

  String _formatFirstLineWithTruncate(String s) {
    final firstLine = s.split('\n').first;
    final hasMore = s.contains('\n');
    const maxLength = 18;
    if (firstLine.length > maxLength) {
      return '${firstLine.substring(0, maxLength)}...';
    }
    return hasMore ? '$firstLine...' : firstLine;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.edit_note_outlined,
          size: AppSizes.p20,
          color: context.appColors.subtleText,
        ),
        gapW4,
        Expanded(
          child: Text(
            _formatFirstLineWithTruncate(text),
            style: context.textStyles.labelSmallRegular.withSubtleTextColor(
              context,
            ),
            maxLines: 1,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}
