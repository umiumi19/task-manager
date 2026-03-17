import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// アイコン + ラベルテキストの行。リストタイル内の日時・場所・メモ表示用。
class IconLabel extends StatelessWidget {
  const IconLabel({
    required this.icon,
    required this.label,
    super.key,
    this.labelColor,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final Color? labelColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: AppSizes.p20,
          color: iconColor ?? context.appColors.subtleText,
        ),
        gapW4,
        Flexible(
          child: Text(
            label,
            style: context.textStyles.labelSmallRegular.copyWith(
              color: labelColor ?? context.appColors.subtleText,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
