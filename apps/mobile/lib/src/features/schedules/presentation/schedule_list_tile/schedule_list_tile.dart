import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../common/constants/app_sizes.dart';
import '../../../../common/theme/app_colors.dart';
import '../../../../common/theme/app_text_styles.dart';
import '../../../../common/utils/date_time_asia.dart';
import '../../../../common/widgets/icon_label.dart';
import '../../domain/schedule.dart';

/// 参照: clalin ScheduleListTile。予定1件をタイトル・日時・場所・メモで表示。
class ScheduleListTile extends StatelessWidget {
  const ScheduleListTile({
    required this.schedule,
    required this.onTap,
    super.key,
    this.borderRadius = const BorderRadius.all(Radius.circular(AppSizes.p8)),
    this.showDate = false,
  });

  final Schedule schedule;
  final VoidCallback onTap;
  final BorderRadiusGeometry borderRadius;

  /// true のとき日付（yyyy年M月d日(E)）を時刻の前に表示。一覧画面用。
  final bool showDate;

  Color _getTileColor(BuildContext context) {
    final now = DateTime.now();
    if (schedule.startAt.isBefore(now)) {
      return context.appColors.cancelledColor;
    }
    return context.appColors.surface;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: _getTileColor(context),
        ),
        padding: tilePadding,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    schedule.title,
                    style: context.textStyles.labelMediumSemibold
                        .withPrimaryTextColor(context),
                  ),
                  gapH8,
                  _DisplayTime(schedule: schedule, showDate: showDate),
                  if (schedule.location != null &&
                      schedule.location!.isNotEmpty) ...[
                    gapH8,
                    _DisplayRoom(schedule: schedule),
                  ],
                  if (schedule.memo != null && schedule.memo!.isNotEmpty) ...[
                    gapH4,
                    _DisplayNote(schedule: schedule),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 時刻を表示。showDate 時は日付（Asia/Tokyo）を前に付ける。API の UTC を Asia/Tokyo (UTC+9) で表示。
class _DisplayTime extends StatelessWidget {
  const _DisplayTime({required this.schedule, this.showDate = false});

  final Schedule schedule;
  final bool showDate;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy年M月d日(E)', 'ja');
    final timeFormat = DateFormat('HH:mm', 'ja');
    final start = toAsiaTokyo(schedule.startAt);
    final end = schedule.endAt != null ? toAsiaTokyo(schedule.endAt!) : null;
    final timeStr = end != null
        ? '${timeFormat.format(start)} - ${timeFormat.format(end)}'
        : timeFormat.format(start);
    final text = showDate ? '${dateFormat.format(start)} $timeStr' : timeStr;

    return Text(
      text,
      style: context.textStyles.labelMediumSemibold.withPrimaryTextColor(
        context,
      ),
    );
  }
}

/// 場所を表示（未入力の場合は呼び出し元で表示しない）。
class _DisplayRoom extends StatelessWidget {
  const _DisplayRoom({required this.schedule});

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return IconLabel(
      icon: Icons.meeting_room_outlined,
      label: schedule.location!,
    );
  }
}

/// メモを1行で表示。長い場合は省略（参照: _DisplayNote）。
class _DisplayNote extends StatelessWidget {
  const _DisplayNote({required this.schedule});

  final Schedule schedule;

  String _formatFirstLineWithTruncate(String text) {
    final firstLine = text.split('\n').first;
    final hasMore = text.contains('\n');
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
            _formatFirstLineWithTruncate(schedule.memo ?? ''),
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
