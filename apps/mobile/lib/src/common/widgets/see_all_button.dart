import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// 「すべて見る」ボタン。バッジ数を任意で表示。
class SeeAllButton extends StatelessWidget {
  const SeeAllButton({required this.onTap, super.key, this.badgeCount});

  final VoidCallback onTap;
  final int? badgeCount;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'すべて見る',
            style: context.textStyles.labelSmallRegular.withSubtleTextColor(
              context,
            ),
          ),
          if (badgeCount != null && badgeCount! > 0) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: context.appColors.unread,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                badgeCount! > 99 ? '99+' : '$badgeCount',
                style: context.textStyles.labelSmallSemibold.copyWith(
                  color: context.appColors.surface,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
