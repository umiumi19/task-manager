import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart'; // 曜日を取得するために追加
import 'package:wheel_chooser/wheel_chooser.dart';

import '../constants/app_dates.dart';
import '../constants/app_sizes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../bottom_sheets/bottom_sheet_selected_background.dart';
import '../bottom_sheets/custom_bottom_sheet.dart';

class DateTimePickerBottomSheet extends HookWidget {
  const DateTimePickerBottomSheet({
    required this.title,
    super.key,
    this.initialValue,
  });

  final String title;
  final DateTime? initialValue;

  @override
  Widget build(BuildContext context) {
    final initialDate =
        initialValue ?? DateTime.now().copyWith(hour: 23, minute: 59);
    final selectedDate = useState<DateTime>(initialDate);

    final dateList = List<DateTime>.generate(
      AppDates.lastDisplayDate.difference(AppDates.firstDisplayDate).inDays + 1,
      (index) => AppDates.firstDisplayDate.add(Duration(days: index)),
    );

    final dateStrings = dateList.map((date) {
      final yy = date.year % 100;
      final m = date.month.toString();
      final d = date.day.toString();
      final weekday = DateFormat.E('ja').format(date);
      return '${yy.toString().padLeft(2, '0')}年$m月$d日($weekday)';
    }).toList();

    final hourList = List<String>.generate(
      24,
      (index) => index.toString().padLeft(2, '0'),
    );
    final minuteList = List<String>.generate(
      60,
      (index) => index.toString().padLeft(2, '0'),
    );

    final initialDateIndex = dateList.indexWhere(
      (date) =>
          date.year == selectedDate.value.year &&
          date.month == selectedDate.value.month &&
          date.day == selectedDate.value.day,
    );

    final initialHourIndex = selectedDate.value.hour;
    final initialMinuteIndex = selectedDate.value.minute;

    return CustomBottomSheet(
      title: title,
      enabled: true,
      bottomButtonTitle: '完了',
      onBottomButtonPressed: () {
        Navigator.of(context).pop(selectedDate.value);
      },
      bodyWidget: SizedBox(
        height: 250,
        child: Row(
          children: [
            // 日付と曜日のピッカー
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const BottomSheetSelectedBackground(
                    padding: EdgeInsets.all(AppSizes.p8),
                  ),
                  WheelChooser<int>.custom(
                    startPosition: initialDateIndex,
                    onValueChanged: (selectedIndex) {
                      // selectedIndex は dynamic として受け取られるのでキャストする
                      final index = selectedIndex as int;
                      final selectedDateTime = dateList[index];
                      selectedDate.value = DateTime(
                        selectedDateTime.year,
                        selectedDateTime.month,
                        selectedDateTime.day,
                        selectedDate.value.hour,
                        selectedDate.value.minute,
                      );
                    },
                    children: dateStrings.map((date) {
                      return Center(
                        child: Text(
                          date,
                          style: context.textStyles.labelMediumRegular.copyWith(
                            color: context.appColors.secondaryText,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const BottomSheetSelectedBackground(
                    padding: EdgeInsets.all(AppSizes.p8),
                  ),
                  Row(
                    children: [
                      // 時間のピッカー
                      Expanded(
                        child: WheelChooser<int>.custom(
                          startPosition: initialHourIndex,
                          isInfinite: true,
                          onValueChanged: (selectedIndex) {
                            final index = selectedIndex as int;
                            final hour = int.parse(hourList[index]);
                            selectedDate.value = DateTime(
                              selectedDate.value.year,
                              selectedDate.value.month,
                              selectedDate.value.day,
                              hour,
                              selectedDate.value.minute,
                            );
                          },
                          children: hourList.map((hour) {
                            return Center(
                              child: Text(
                                hour,
                                style: context.textStyles.labelMediumRegular
                                    .copyWith(
                                      color: context.appColors.secondaryText,
                                    ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Text(
                        ':',
                        style: context.textStyles.labelMediumRegular
                            .withSecondaryTextColor(context),
                      ),
                      // 分のピッカー
                      Expanded(
                        child: WheelChooser<int>.custom(
                          isInfinite: true,
                          startPosition: initialMinuteIndex,
                          onValueChanged: (selectedIndex) {
                            final minute = int.parse(
                              minuteList[selectedIndex as int],
                            );
                            selectedDate.value = DateTime(
                              selectedDate.value.year,
                              selectedDate.value.month,
                              selectedDate.value.day,
                              selectedDate.value.hour,
                              minute,
                            );
                          },
                          children: minuteList.map((minute) {
                            return Center(
                              child: Text(
                                minute,
                                style: context.textStyles.labelMediumRegular
                                    .copyWith(
                                      color: context.appColors.secondaryText,
                                    ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
