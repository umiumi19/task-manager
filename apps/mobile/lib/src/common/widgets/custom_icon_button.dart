import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import '../theme/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.icon,
    this.iconSize,
    this.color,
    this.onPressed,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(AppSizes.p4),
    this.isElevated = false, // ← デフォルトは false
    super.key,
  });

  final double? iconSize;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final bool isElevated; // ← 追加

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor ?? context.appColors.transparent,
          shape: BoxShape.circle,
          boxShadow: isElevated
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(50),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [], // ← isElevated によって影を切り替える
        ),
        child: Icon(
          icon,
          size: iconSize ?? 24,
          color: color ?? context.appColors.subtleText,
        ),
      ),
    );
  }
}
