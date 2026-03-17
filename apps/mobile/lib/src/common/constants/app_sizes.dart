import 'package:flutter/material.dart';

/// Constant sizes to be used in the app (paddings, gaps, rounded corners etc.)
class AppSizes {
  AppSizes._();

  static const p2 = 2.0;
  static const p4 = 4.0;
  static const p6 = 6.0;
  static const p8 = 8.0;
  static const p12 = 12.0;
  static const p14 = 14.0; // readOnlyTextField用に追加
  static const p16 = 16.0;
  static const p20 = 20.0;
  static const p24 = 24.0;
  static const p32 = 32.0;
  static const p36 = 36.0; // コメント一覧アバター
  static const p48 = 48.0;
  static const p64 = 64.0;
  static const timetableCellH = 100.0;
  static const editTimetableHeaderH = 24.0;
  static const periodW = 30.0;
  static const halfStrokeW = 0.25;
  static const strokeW = 0.5;
  static const double timetableHeaderH = weekdayHeaderH + todoCountHeaderH;
  static const weekdayHeaderH = 40.0;
  static const todoCountHeaderH = 16.0;
  static const calendarCircleSize = 6.0;
  static const tileHeight = 88.0;
  static const monthViewScheduleHeight = 12.0;
}

/// Constant gap widths
const gapW2 = SizedBox(width: AppSizes.p2);
const gapW4 = SizedBox(width: AppSizes.p4);
const gapW8 = SizedBox(width: AppSizes.p8);
const gapW12 = SizedBox(width: AppSizes.p12);
const gapW16 = SizedBox(width: AppSizes.p16);
const gapW20 = SizedBox(width: AppSizes.p20);
const gapW24 = SizedBox(width: AppSizes.p24);
const gapW32 = SizedBox(width: AppSizes.p32);
const gapW48 = SizedBox(width: AppSizes.p48);
const gapW64 = SizedBox(width: AppSizes.p64);

/// Constant gap heights
const gapH2 = SizedBox(height: AppSizes.p2);
const gapH4 = SizedBox(height: AppSizes.p4);
const gapH8 = SizedBox(height: AppSizes.p8);
const gapH12 = SizedBox(height: AppSizes.p12);
const gapH16 = SizedBox(height: AppSizes.p16);
const gapH20 = SizedBox(height: AppSizes.p20);
const gapH24 = SizedBox(height: AppSizes.p24);
const gapH32 = SizedBox(height: AppSizes.p32);
const gapH48 = SizedBox(height: AppSizes.p48);
const gapH64 = SizedBox(height: AppSizes.p64);

const tilePadding = EdgeInsets.symmetric(
  horizontal: AppSizes.p12,
  vertical: AppSizes.p12,
);
const pagePadding = EdgeInsets.fromLTRB(
  AppSizes.p16,
  AppSizes.p16,
  AppSizes.p16,
  AppSizes.p36,
);
const formPagePadding = EdgeInsets.fromLTRB(
  AppSizes.p24,
  AppSizes.p24,
  AppSizes.p24,
  AppSizes.p36,
);
const double formWidgetSpacing = AppSizes.p24;
const double sectionSpacing = AppSizes.p16;
