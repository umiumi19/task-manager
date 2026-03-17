import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    required this.title,
    required this.defaultActionText,
    super.key,
    this.content,
    this.defaultActionTextColor,
    this.cancelActionText,
    this.cancleActionTextColor,
  });

  final String title;
  final String? content;
  final String defaultActionText;
  final Color? defaultActionTextColor;
  final String? cancelActionText;
  final Color? cancleActionTextColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: context.textStyles.bodyMediumRegular.withPrimaryTextColor(
          context,
        ),
      ),
      content: content != null
          ? Text(
              content!,
              style: context.textStyles.bodySmallRegular.withSecondaryTextColor(
                context,
              ),
            )
          : null,
      actions: <Widget>[
        if (cancelActionText != null)
          TextButton(
            child: Text(
              cancelActionText!,
              style: context.textStyles.labelLargeBold.copyWith(
                color: cancleActionTextColor ?? context.appColors.pointOrange,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        TextButton(
          child: Text(
            defaultActionText,
            style: context.textStyles.labelMediumRegular.copyWith(
              color: defaultActionTextColor ?? context.appColors.pointBlue,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
