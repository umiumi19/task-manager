import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_sizes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    super.key,
    this.hintText,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.errorMessage,
    this.onChanged,
    this.showBorder = false,
    this.autoFocus = false,
    this.scrollController,
  });

  final TextEditingController controller;
  final String? hintText;
  final bool enabled;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final String? errorMessage;
  final ValueChanged<String>? onChanged;
  final bool showBorder;
  final bool autoFocus;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    // ※ バリデーションロジックは親側で実施し、エラーがある場合は errorMessage に値がセットされる前提です。
    return TextField(
      autofocus: autoFocus,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      enabled: enabled,
      cursorColor: context.appColors.primary,
      maxLength: maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      minLines: minLines,
      maxLines: maxLines,
      scrollController: scrollController,
      decoration: InputDecoration(
        error: errorMessage != null && errorMessage!.isNotEmpty
            ? Text(
                errorMessage!,
                style: context.textStyles.labelSmallRegular.withErrorColor(
                  context,
                ),
              )
            : null,
        counterStyle: context.textStyles.labelSmallRegular.withSubtleTextColor(
          context,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.all(AppSizes.p8),
        fillColor: enabled
            ? context.appColors.surface
            : context.appColors.backgroundVariant,
        filled: true,
        hintText: hintText,
        counterText: '',
        counter: const SizedBox.shrink(),
        hintStyle: context.textStyles.labelMediumRegular.withEmptyTextColor(
          context,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: showBorder
                ? context.appColors.primary
                : context.appColors.transparent,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(AppSizes.p8)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.appColors.transparent),
          borderRadius: const BorderRadius.all(Radius.circular(AppSizes.p8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.appColors.primary),
          borderRadius: const BorderRadius.all(Radius.circular(AppSizes.p8)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: showBorder
                ? context.appColors.stroke
                : context.appColors.transparent,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(AppSizes.p8)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.appColors.error),
          borderRadius: const BorderRadius.all(Radius.circular(AppSizes.p8)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.appColors.error),
          borderRadius: const BorderRadius.all(Radius.circular(AppSizes.p8)),
        ),
      ),
      style: context.textStyles.labelMediumRegular.withSecondaryTextColor(
        context,
      ),
      onChanged: onChanged,
    );
  }
}
