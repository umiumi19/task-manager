import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import '../theme/app_colors.dart';

class BottomSheetSelectedBackground extends StatelessWidget {
  const BottomSheetSelectedBackground({
    super.key,
    this.height = 50,
    this.padding = EdgeInsets.zero,
  });

  final double height;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        height: 50, // 背景の高さを指定
        decoration: BoxDecoration(
          color: context.appColors.background,
          borderRadius: BorderRadius.circular(AppSizes.p8),
        ),
      ),
    );
  }
}
