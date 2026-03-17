import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// ローディング用のプレースホルダー（角丸の単色ブロック）。
class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    required this.height,
    super.key,
    this.width,
    this.borderRadius = 8,
  });

  final double height;
  final double? width;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: context.appColors.backgroundVariant,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
