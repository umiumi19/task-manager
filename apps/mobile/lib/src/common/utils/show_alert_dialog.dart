import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_alert_dialog.dart';
import '../widgets/custom_cupertino_alert_dialog.dart';
import '../theme/app_colors.dart';

Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  required String defaultActionText,
  String? content,
  String? cancelActionText,
  Color? cancleActionTextColor,
  Color? defaultActionTextColor,
}) async {
  if (kIsWeb || !Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: title,
        content: content,
        defaultActionText: defaultActionText,
        defaultActionTextColor: defaultActionTextColor,
        cancelActionText: cancelActionText,
        cancleActionTextColor: cancleActionTextColor,
      ),
    );
  }
  return showCupertinoDialog(
    context: context,
    builder: (context) => CustomCupertinoAlertDialog(
      title: title,
      content: content,
      defaultActionText: defaultActionText,
      defaultActionIsBlue:
          defaultActionTextColor == context.appColors.pointBlue ||
          defaultActionTextColor == null,
      cancelActionText: cancelActionText,
      cancelActionIsBlue:
          cancleActionTextColor == context.appColors.pointBlue ||
          cancleActionTextColor == null,
    ),
  );
}
