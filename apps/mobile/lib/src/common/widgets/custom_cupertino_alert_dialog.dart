import 'package:flutter/cupertino.dart';

import '../theme/app_text_styles.dart';

// 引数で直接色を渡すと色が変わらないので、bool型で色を変更するかどうかを判断するように変更
// 理由は不明
class CustomCupertinoAlertDialog extends StatelessWidget {
  const CustomCupertinoAlertDialog({
    required this.title,
    required this.defaultActionText,
    super.key,
    this.content,
    this.defaultActionIsBlue = true,
    this.cancelActionText,
    this.cancelActionIsBlue = true,
  });

  final String title;
  final String? content;
  final String defaultActionText;
  final bool? defaultActionIsBlue;
  final String? cancelActionText;
  final bool? cancelActionIsBlue;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title, style: context.textStyles.headingLargeRegular),
      content: content != null
          ? Text(content!, style: context.textStyles.labelSmallRegular)
          : null,
      actions: <Widget>[
        if (cancelActionText != null)
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              cancelActionText!,
              style: TextStyle(
                color: cancelActionIsBlue!
                    ? CupertinoColors.activeBlue
                    : CupertinoColors.systemRed,
              ),
            ),
          ),
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            defaultActionText,
            style: TextStyle(
              color: defaultActionIsBlue!
                  ? CupertinoColors.activeBlue
                  : CupertinoColors.systemRed,
            ),
          ),
        ),
      ],
    );
  }
}
