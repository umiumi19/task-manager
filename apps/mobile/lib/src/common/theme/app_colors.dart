import 'package:flutter/material.dart';

/// アプリ全体で使う独自のカラーをまとめた ThemeExtension
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.clalinBlue,
    required this.primaryText,
    required this.secondaryText,
    required this.subtleText,
    required this.emptyText,
    required this.stroke,
    required this.backgroundVariant,
    required this.background,
    required this.surface,
    required this.unread,
    required this.cellFrame,
    required this.error,
    required this.alert,
    required this.red,
    required this.magenta,
    required this.violet,
    required this.blue,
    required this.azure,
    required this.lightBlue,
    required this.lime,
    required this.lightGreen,
    required this.yellow,
    required this.orange,
    required this.pointOrange,
    required this.pointBlue,
    required this.pointGreen,
    required this.transparent,
    required this.cancelledColor,
    required this.overlayColor,
    required this.barrierColor,
    required this.cancelledFrame,
    required this.todo,
    required this.test,
    required this.remote,
    required this.normalLecture,
  });
  final Color primary;
  final Color clalinBlue;
  final Color primaryText;
  final Color secondaryText;
  final Color subtleText;
  final Color emptyText;
  final Color stroke;
  final Color backgroundVariant;
  final Color background;
  final Color surface;
  final Color unread;
  final Color cellFrame;
  final Color error;
  final Color alert;

  // Timetable cell colors
  final Color red;
  final Color magenta;
  final Color violet;
  final Color blue;
  final Color azure;
  final Color lightBlue;
  final Color lime;
  final Color lightGreen;
  final Color yellow;
  final Color orange;

  // Point colors
  final Color pointOrange;
  final Color pointBlue;
  final Color pointGreen;

  // Else
  final Color transparent;
  final Color cancelledColor;
  final Color overlayColor;
  final Color barrierColor;
  final Color cancelledFrame;
  final Color todo;
  final Color test;
  final Color remote;
  final Color normalLecture;

  /// ライトテーマ用の定数
  /// （必要に応じて値を変える・追加する）
  static const AppColors light = AppColors(
    primary: Color(0xFF21AAE6),
    clalinBlue: Color(0xFF2187E6),
    primaryText: Color(0xFF232423),
    secondaryText: Color(0xFF606060),
    subtleText: Color(0xFF909090),
    emptyText: Color(0xFFBABABA),
    stroke: Color(0xFFDDDDDD),
    backgroundVariant: Color(0xFFEEEEEE),
    background: Color(0xFFF7F7F7),
    surface: Color(0xFFFFFFFF),
    unread: Color.fromARGB(255, 221, 238, 245),
    cellFrame: Color(0xFFDDDDDD),
    error: Color.fromARGB(255, 244, 73, 73),
    alert: Color.fromARGB(255, 255, 140, 0),

    // timetable cell colors
    red: Color(0xFFFFD1D1),
    magenta: Color(0xFFFFD1FF),
    violet: Color(0xFFE8D1FF),
    blue: Color(0xFFD1D1FF),
    azure: Color(0xFFD1E8FF),
    lightBlue: Color(0xFFD1FFFF),
    lime: Color(0xFFD1FFD1),
    lightGreen: Color(0xFFE8FFD1),
    yellow: Color(0xFFFFFFD1),
    orange: Color(0xFFFFE8D1),

    // Point colors
    pointOrange: Color(0xFFFF6F61),
    pointBlue: Color(0xFF4682B4),
    pointGreen: Color(0xFF1DBD6F),

    // else
    transparent: Color(0x00000000),
    cancelledColor: Color(0xFFEEEEEE),
    overlayColor: Color.fromARGB(231, 255, 255, 255),
    barrierColor: Colors.black54,
    cancelledFrame: Color(0xFFBABABA),
    todo: Color(0xFF1DBD6F),
    test: Color(0xFF21AAE6),
    remote: Color(0xFF4682B4),
    normalLecture: Color(0xFF21AAE6),
  );

  /// ダークテーマ用の定数（必要に応じて変更する）
  static const AppColors dark = AppColors(
    // ブランドカラーはそのまま採用
    primary: Color(0xFF21AAE6),
    clalinBlue: Color(0xFF2187E6),

    // テキストは明るめの色にして、背景とのコントラストを確保
    primaryText: Color(0xFFE0E0E0),
    secondaryText: Color.fromARGB(255, 198, 197, 197),
    subtleText: Color(0xFF909090),
    emptyText: Color(0xFF707070),

    // 境界線などはダークなグレー
    stroke: Color(0xFF444444),

    // 背景系は暗めに。背景とそのバリエーション、カードなどに用いるサーフェスカラーも調整
    backgroundVariant: Color(0xFF333333),
    background: Color(0xFF121212),
    surface: Color.fromARGB(255, 43, 43, 43),

    // 未読マーカーも暗い背景に映えるように、ややくすんだブルートーンに
    unread: Color.fromARGB(255, 30, 45, 55),

    // セルの枠線は明るめの色にして、セルの境界をわかりやすく
    cellFrame: Color(0xFF666666),

    error: Color(0xFFE57373),
    alert: Color(0xFFFFA726),

    // ── タイムテーブルセル用の色 ──
    // light 版はパステル調の明るい色ですが、ダーク版では背景に対して
    // しっかりと見えるように、明度を下げたバージョンを用意しています。
    red: Color(0xFFAF8181), // (255,209,209) → (175,129,129)
    magenta: Color(0xFFAF81AF), // (255,209,255) → (175,129,175)
    violet: Color(0xFF9881AF), // (232,209,255) → (152,129,175)
    blue: Color(0xFF8181AF), // (209,209,255) → (129,129,175)
    azure: Color.fromARGB(255, 29, 107, 185), // (209,232,255) → (129,152,175)
    lightBlue: Color(0xFF81AFAF), // (209,255,255) → (129,175,175)
    lime: Color(0xFF81AF81), // (209,255,209) → (129,175,129)
    lightGreen: Color(0xFF98AF81), // (232,255,209) → (152,175,129)
    yellow: Color(0xFFAFAF81), // (255,255,209) → (175,175,129)
    orange: Color(0xFFAF9881), // (255,232,209) → (175,152,129)
    // ── 強調色（ポイントカラー）はブランドカラーに合わせるか、必要に応じて調整 ──
    pointOrange: Color(0xFFFF6F61),
    pointBlue: Color(0xFF4682B4),
    pointGreen: Color(0xFF1DBD6F),

    // ── その他 ──
    transparent: Color(0x00000000),
    cancelledColor: Color(0xFF444444), // 例：取り消し状態用の背景色
    overlayColor: Color(0x90000000), // 黒を90（16進数 0x90）の透過度で重ねる
    barrierColor: Colors.white54, // ダークテーマでは白の透過度54%を使用
    cancelledFrame: Color(0xFF707070),
    todo: Color(0xFF1DBD6F),
    test: Color.fromARGB(255, 39, 110, 140),
    remote: Color(0xFF4682B4),
    normalLecture: Color.fromARGB(255, 39, 110, 140),
  );

  @override
  AppColors copyWith({
    Color? primary,
    Color? clalinBlue,
    Color? primaryText,
    Color? secondaryText,
    Color? subtleText,
    Color? emptyText,
    Color? stroke,
    Color? backgroundVariant,
    Color? background,
    Color? surface,
    Color? unread,
    Color? cellFrame,
    Color? error,
    Color? alert,
    Color? red,
    Color? magenta,
    Color? violet,
    Color? blue,
    Color? azure,
    Color? lightBlue,
    Color? lime,
    Color? lightGreen,
    Color? yellow,
    Color? orange,
    Color? pointOrange,
    Color? pointBlue,
    Color? pointGreen,
    Color? transparent,
    Color? cancelledColor,
    Color? overlayColor,
    Color? barrierColor,
    Color? cancelledFrame,
    Color? todo,
    Color? test,
    Color? remote,
    Color? normalLecture,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      clalinBlue: clalinBlue ?? this.clalinBlue,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      subtleText: subtleText ?? this.subtleText,
      emptyText: emptyText ?? this.emptyText,
      stroke: stroke ?? this.stroke,
      backgroundVariant: backgroundVariant ?? this.backgroundVariant,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      unread: unread ?? this.unread,
      cellFrame: cellFrame ?? this.cellFrame,
      error: error ?? this.error,
      alert: alert ?? this.alert,
      red: red ?? this.red,
      magenta: magenta ?? this.magenta,
      violet: violet ?? this.violet,
      blue: blue ?? this.blue,
      azure: azure ?? this.azure,
      lightBlue: lightBlue ?? this.lightBlue,
      lime: lime ?? this.lime,
      lightGreen: lightGreen ?? this.lightGreen,
      yellow: yellow ?? this.yellow,
      orange: orange ?? this.orange,
      pointOrange: pointOrange ?? this.pointOrange,
      pointBlue: pointBlue ?? this.pointBlue,
      pointGreen: pointGreen ?? this.pointGreen,
      transparent: transparent ?? this.transparent,
      cancelledColor: cancelledColor ?? this.cancelledColor,
      overlayColor: overlayColor ?? this.overlayColor,
      barrierColor: barrierColor ?? this.barrierColor,
      cancelledFrame: cancelledFrame ?? this.cancelledFrame,
      todo: todo ?? this.todo,
      test: test ?? this.test,
      remote: remote ?? this.remote,
      normalLecture: normalLecture ?? this.normalLecture,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      clalinBlue: Color.lerp(clalinBlue, other.clalinBlue, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      subtleText: Color.lerp(subtleText, other.subtleText, t)!,
      emptyText: Color.lerp(emptyText, other.emptyText, t)!,
      stroke: Color.lerp(stroke, other.stroke, t)!,
      backgroundVariant: Color.lerp(
        backgroundVariant,
        other.backgroundVariant,
        t,
      )!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      unread: Color.lerp(unread, other.unread, t)!,
      cellFrame: Color.lerp(cellFrame, other.cellFrame, t)!,
      error: Color.lerp(error, other.error, t)!,
      alert: Color.lerp(alert, other.alert, t)!,
      red: Color.lerp(red, other.red, t)!,
      magenta: Color.lerp(magenta, other.magenta, t)!,
      violet: Color.lerp(violet, other.violet, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      azure: Color.lerp(azure, other.azure, t)!,
      lightBlue: Color.lerp(lightBlue, other.lightBlue, t)!,
      lime: Color.lerp(lime, other.lime, t)!,
      lightGreen: Color.lerp(lightGreen, other.lightGreen, t)!,
      yellow: Color.lerp(yellow, other.yellow, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      pointOrange: Color.lerp(pointOrange, other.pointOrange, t)!,
      pointBlue: Color.lerp(pointBlue, other.pointBlue, t)!,
      pointGreen: Color.lerp(pointGreen, other.pointGreen, t)!,
      transparent: Color.lerp(transparent, other.transparent, t)!,
      cancelledColor: Color.lerp(cancelledColor, other.cancelledColor, t)!,
      overlayColor: Color.lerp(overlayColor, other.overlayColor, t)!,
      barrierColor: Color.lerp(barrierColor, other.barrierColor, t)!,
      cancelledFrame: Color.lerp(cancelledFrame, other.cancelledFrame, t)!,
      todo: Color.lerp(todo, other.todo, t)!,
      test: Color.lerp(test, other.test, t)!,
      remote: Color.lerp(remote, other.remote, t)!,
      normalLecture: Color.lerp(normalLecture, other.normalLecture, t)!,
    );
  }

  static Color fromLectureColorName({
    required BuildContext context,
    required String value,
  }) {
    switch (value) {
      case 'red':
        return context.appColors.red;
      case 'magenta':
        return context.appColors.magenta;
      case 'violet':
        return context.appColors.violet;
      case 'blue':
        return context.appColors.blue;
      case 'azure':
        return context.appColors.azure;
      case 'lightBlue':
        return context.appColors.lightBlue;
      case 'lime':
        return context.appColors.lime;
      case 'lightGreen':
        return context.appColors.lightGreen;
      case 'yellow':
        return context.appColors.yellow;
      case 'orange':
        return context.appColors.orange;
      default:
        return context.appColors.surface;
    }
  }

  static String toLectureColorName({
    required BuildContext context,
    required Color value,
  }) {
    if (value == context.appColors.red) {
      return 'red';
    } else if (value == context.appColors.magenta) {
      return 'magenta';
    } else if (value == context.appColors.violet) {
      return 'violet';
    } else if (value == context.appColors.blue) {
      return 'blue';
    } else if (value == context.appColors.azure) {
      return 'azure';
    } else if (value == context.appColors.lightBlue) {
      return 'lightBlue';
    } else if (value == context.appColors.lime) {
      return 'lime';
    } else if (value == context.appColors.lightGreen) {
      return 'lightGreen';
    } else if (value == context.appColors.yellow) {
      return 'yellow';
    } else if (value == context.appColors.orange) {
      return 'orange';
    }
    return '';
  }

  static List<Color> lectureColors(BuildContext context) {
    return [
      context.appColors.red,
      context.appColors.magenta,
      context.appColors.violet,
      context.appColors.blue,
      context.appColors.azure,
      context.appColors.lightBlue,
      context.appColors.lime,
      context.appColors.lightGreen,
      context.appColors.yellow,
      context.appColors.orange,
    ];
  }
}

extension AppThemeColorsBuildContext on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
