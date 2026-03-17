import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/primary_button.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    required this.bodyWidget,
    required this.enabled,
    this.title,
    super.key,
    this.bottomButtonTitle,
    this.onBottomButtonPressed,
    this.topLeftWidget,
  }) : assert(
         (bottomButtonTitle == null) == (onBottomButtonPressed == null),
         'bottomButtonTitleとonBottomButtonPressedは共にnullか共にnullでなければなりません',
       );

  final String? title;
  final Widget bodyWidget;
  final String? bottomButtonTitle;
  final VoidCallback? onBottomButtonPressed;
  final bool enabled;
  final Widget? topLeftWidget;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          if (title != null)
            Positioned(
              left: 0,
              right: 0,
              top: AppSizes.p16,
              child: Center(
                child: Text(
                  title!,
                  style: context.textStyles.headingMediumSemibold
                      .withPrimaryTextColor(context),
                ),
              ),
            ),
          // 閉じるボタン
          Positioned(
            right: AppSizes.p8,
            top: AppSizes.p12, // 12にしないと上にずれる
            child: CustomIconButton(
              icon: Icons.close,
              iconSize: AppSizes.p24,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          // 左上のカスタムウィジェット
          if (topLeftWidget != null)
            Positioned(
              left: AppSizes.p8,
              top: AppSizes.p12,
              child: topLeftWidget!,
            ),
          Padding(
            padding: onBottomButtonPressed == null
                ? const EdgeInsets.fromLTRB(24, 48, 24, 24)
                : const EdgeInsets.fromLTRB(24, 48, 24, 80),
            child: bodyWidget,
          ),
          if (onBottomButtonPressed != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: PrimaryButton(
                onPressed: onBottomButtonPressed,
                text: bottomButtonTitle!,
                enabled: enabled,
              ),
            ),
        ],
      ),
    );
  }
}
