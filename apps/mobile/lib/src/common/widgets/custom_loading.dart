import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

// ここでは文字があると逆にわかりづらくなる可能性があるので、処理時間が長くなる可能性があるもの
// のみloadingMessageを渡す。それ以外は表示しない。
class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
    this.loadingMessage,
    this.loadingColor,
    this.loadingMessageColor,
  });

  final String? loadingMessage;
  final Color? loadingColor;
  final Color? loadingMessageColor;

  @override
  Widget build(BuildContext context) {
    return loadingMessage != null
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: AppSizes.p20, // labelMediumLargeのフォント高さと同じ
                  width: AppSizes.p20, // labelMediumLargeのフォント高さと同じ
                  child: CircularProgressIndicator(
                    color: loadingColor ?? context.appColors.surface,
                    strokeWidth: 4,
                  ),
                ),
                gapH16,
                Text(
                  loadingMessage!,
                  style: context.textStyles.headingLargeRegular.copyWith(
                    color: loadingMessageColor ?? context.appColors.surface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        : Center(
            child: SizedBox(
              height: AppSizes.p20, // labelMediumLargeのフォント高さと同じ
              width: AppSizes.p20, // labelMediumLargeのフォント高さと同じ
              child: CircularProgressIndicator(
                color: loadingColor ?? context.appColors.surface,
                strokeWidth: 4,
              ),
            ),
          );
  }
}
