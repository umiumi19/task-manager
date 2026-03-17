import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import '../theme/app_colors.dart';

Future<T?> showCustomBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  double heightRatio = 0.85,
  double minHeight = 250,
  Color? color,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  final screenHeight = MediaQuery.of(context).size.height;
  final calculatedHeight = screenHeight * heightRatio;

  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: color ?? context.appColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppSizes.p24),
        topRight: Radius.circular(AppSizes.p24),
      ),
    ),
    constraints: BoxConstraints(
      minHeight: minHeight,
      maxHeight: calculatedHeight,
    ),
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    builder: (context) {
      return child;
    },
  );
}
