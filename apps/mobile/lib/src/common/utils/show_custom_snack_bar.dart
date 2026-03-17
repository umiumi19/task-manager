import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import '../constants/keys.dart';
import '../../core/exceptions/error_response_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

void showCustomSnackBar({
  String successMessage = '',
  String failMessage = '',
  dynamic error,
  bool isSuccessful = true,
  VoidCallback? rollback,
  Duration duration = const Duration(milliseconds: 2500),
}) {
  // successMessage と failMessage が両方空文字の場合は、文法エラーのメッセージを表示する
  if (successMessage.isEmpty && failMessage.isEmpty && error == null) {
    throw AssertionError(
      'You must provide either successMessage or failMessage when error is not null.',
    );
  }
  final messenger = Keys.rootScaffoldMessengerKey.currentState;
  // 既存の SnackBar があれば消去
  messenger?.hideCurrentSnackBar();

  final context = Keys.rootScaffoldMessengerKey.currentContext;

  Keys.rootScaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: isSuccessful
          ? context?.appColors.primaryText
          : context?.appColors.error,
      content: Row(
        children: [
          Icon(
            isSuccessful ? Icons.check_circle : Icons.error,
            color: context?.appColors.surface,
          ),
          gapW8,
          Expanded(
            child: Text(
              textAlign: TextAlign.start,
              isSuccessful
                  ? successMessage
                  : failMessage.isEmpty
                  ? ErrorResponseModel.getErrorMessage(error)
                  : failMessage,
              style: context?.textStyles.bodyMediumRegular.withSurfaceColor(
                context,
              ),
            ),
          ),
          if (rollback != null)
            GestureDetector(
              onTap: rollback,
              child: Text(
                '元に戻す',
                style: context?.textStyles.bodyMediumRegular
                    .withSubtleTextColor(context),
              ),
            ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.p8),
      ),
      duration: duration,
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 32),
    ),
  );
}
