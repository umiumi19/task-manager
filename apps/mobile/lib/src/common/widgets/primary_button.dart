import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'custom_loading.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.text,
    super.key,
    this.isLoading = false,
    this.enabled = true,
    this.margin = const EdgeInsets.symmetric(
      horizontal: AppSizes.p24,
      vertical: AppSizes.p16,
    ),
    this.onPressed, // 同期: void Function()
    this.color,
  });

  final String text;
  final bool isLoading;
  final bool enabled;
  final EdgeInsets margin;

  /// 同期ハンドラ（ローディングは出さない）
  final VoidCallback? onPressed;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final disabled = isLoading || !enabled || (onPressed == null);

    return GestureDetector(
      onTap: disabled ? null : onPressed?.call,
      child: Container(
        width: double.infinity,
        margin: margin,
        decoration: BoxDecoration(
          color: !enabled
              ? context.appColors.emptyText
              : color ?? context.appColors.primary,
          borderRadius: BorderRadius.circular(AppSizes.p8),
          border: Border.all(
            color: !enabled
                ? context.appColors.emptyText
                : color ?? context.appColors.primary,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.p12),
          child: isLoading
              ? CustomLoading(loadingColor: context.appColors.surface)
              : Text(
                  text,
                  textAlign: TextAlign.center,
                  style: context.textStyles.labelMediumSemibold
                      .withSurfaceColor(context),
                ),
        ),
      ),
    );
  }
}
