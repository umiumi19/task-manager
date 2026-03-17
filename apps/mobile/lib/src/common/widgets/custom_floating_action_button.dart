import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    required this.onPressed,
    required this.heroTag,
    super.key,
    this.icon = Icons.add,
    this.backgroundColor,
    this.iconColor,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final Object heroTag;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      heroTag: heroTag,
      backgroundColor: backgroundColor ?? context.appColors.primary,
      child: Icon(icon, color: iconColor ?? context.appColors.surface),
    );
  }
}
