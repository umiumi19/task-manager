import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 曜日を取得するために追加

import '../constants/app_sizes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/show_custom_bottom_sheet.dart';
import '../bottom_sheets/date_time_picker_bottom_sheet.dart';

class DateTimeSelectField extends StatelessWidget {
  const DateTimeSelectField({
    required this.title,
    required this.value,
    required this.onChanged,
    super.key,
    this.enabled = true,
    this.errorMessage,
  });

  final String title;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final bool enabled;
  final String? errorMessage;

  static String _digits(int value, int length) {
    return '$value'.padLeft(length, '0');
  }

  @override
  Widget build(BuildContext context) {
    Future<void> showCustomDateTimePickerBottomSheet() async {
      final result = await showCustomBottomSheet<DateTime>(
        context: context,
        child: DateTimePickerBottomSheet(title: title, initialValue: value),
      );
      if (result != null) {
        onChanged(result);
      }
    }

    return GestureDetector(
      onTap: enabled
          ? () async {
              FocusManager.instance.primaryFocus?.unfocus();
              await showCustomDateTimePickerBottomSheet();
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.p8),
        decoration: BoxDecoration(
          color: enabled
              ? context.appColors.surface
              : context.appColors.backgroundVariant,
          borderRadius: BorderRadius.circular(AppSizes.p8),
        ),
        child: Row(
          children: [
            if (value != null)
              Expanded(
                child: Text(
                  '${_digits(value!.year, 4)}年'
                  '${_digits(value!.month, 1)}月'
                  '${_digits(value!.day, 1)}日 '
                  '(${DateFormat.E('ja').format(value!)})  '
                  '${_digits(value!.hour, 1)}:'
                  '${_digits(value!.minute, 2)}',
                  style: context.textStyles.labelMediumRegular
                      .withSecondaryTextColor(context),
                ),
              ),
            if (value == null) const Spacer(),
            if (enabled)
              Icon(Icons.arrow_drop_down, color: context.appColors.subtleText),
            if (errorMessage != null && errorMessage!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Text(
                  errorMessage!,
                  style: context.textStyles.labelSmallRegular.withErrorColor(
                    context,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
