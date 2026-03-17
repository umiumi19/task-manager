import 'package:flutter/material.dart';

import 'app_colors.dart';

/// アプリ全体で使うテキストスタイルをまとめた ThemeExtension
class AppTextStyles extends ThemeExtension<AppTextStyles> {
  const AppTextStyles({
    required this.headingXLargeSemiBold,
    required this.headingLargeRegular,
    required this.headingMediumBold,
    required this.headingMediumSemibold,
    required this.labelXlargeRegular,
    required this.labelLargeBold,
    required this.labelMediumSemibold,
    required this.labelMediumRegular,
    required this.labelSmallRegular,
    required this.labelSmallSemibold,
    required this.labelXsmallSemibold,
    required this.labelTinyRegular,
    required this.labelTinyBold,
    required this.bodyMediumRegular,
    required this.bodySmallRegular,
  });

  // Heading系 - タイトルや見出し用
  final TextStyle headingXLargeSemiBold; // 24px Regular - オンボーディングタイトル
  final TextStyle headingLargeRegular; // 16px Regular - タブの文字
  final TextStyle headingMediumBold; // 14px Bold - アップバー
  final TextStyle headingMediumSemibold; // 14px Medium - 見出し

  // Label系 - ラベルやデータ表示用
  final TextStyle labelXlargeRegular; // 32px Regular - 統計数字
  final TextStyle labelLargeBold; // 16px Bold - メインボタン
  final TextStyle labelMediumSemibold; // 14px Medium - タイルタイトル
  final TextStyle labelMediumRegular; // 14px Regular - 通常ラベル
  final TextStyle labelSmallRegular; // 12px Regular - 補足情報
  final TextStyle labelSmallSemibold; // 12px Medium - 単体ラベル
  final TextStyle labelXsmallSemibold; // 10px Medium - 時間割科目名
  final TextStyle labelTinyRegular; // 8px Regular - 極小補足
  final TextStyle labelTinyBold; // 8px Bold - 時間割時刻

  // Body系 - 本文用
  final TextStyle bodyMediumRegular; // 14px Regular - 標準テキスト
  final TextStyle bodySmallRegular; // 12px Regular - 小さいテキスト

  /// 共通のベーススタイルを作成（ライト・ダークで共通の属性）
  static const String _fontFamily = 'NotoSansJP';

  /// 静的な定数はThemeデータに依存しないスタイル設定のみを含む
  /// 色はcontext.appColorsから取得するため、ここではデフォルト値のみ設定
  static const AppTextStyles base = AppTextStyles(
    // Heading系
    headingXLargeSemiBold: TextStyle(
      fontSize: 28,
      height: 1.5, // 36 / 24 = 1.5
      fontWeight: FontWeight.w500,
      fontFamily: _fontFamily,
    ),
    headingLargeRegular: TextStyle(
      fontSize: 16,
      height: 1.5, // 24 / 16 = 1.5
      fontWeight: FontWeight.w400,
      fontFamily: _fontFamily,
    ),
    headingMediumBold: TextStyle(
      fontSize: 14,
      height: 1.5,
      fontWeight: FontWeight.bold,
      fontFamily: _fontFamily,
    ),
    headingMediumSemibold: TextStyle(
      fontSize: 14,
      height: 1.5,
      fontWeight: FontWeight.w500,
      fontFamily: _fontFamily,
    ),

    // Label系
    labelXlargeRegular: TextStyle(
      fontSize: 32,
      height: 1.5,
      fontWeight: FontWeight.w400,
      fontFamily: _fontFamily,
    ),
    labelLargeBold: TextStyle(
      fontSize: 16,
      height: 1.5,
      fontWeight: FontWeight.bold,
      fontFamily: _fontFamily,
    ),
    labelMediumSemibold: TextStyle(
      fontSize: 14,
      height: 1.43,
      fontWeight: FontWeight.w500,
      fontFamily: _fontFamily,
    ),
    labelMediumRegular: TextStyle(
      fontSize: 14,
      height: 1.43,
      fontWeight: FontWeight.w400,
      fontFamily: _fontFamily,
    ),
    labelSmallRegular: TextStyle(
      fontSize: 12,
      height: 1.5,
      fontWeight: FontWeight.w400,
      fontFamily: _fontFamily,
    ),
    labelSmallSemibold: TextStyle(
      fontSize: 12,
      height: 1.5,
      fontWeight: FontWeight.w500,
      fontFamily: _fontFamily,
    ),
    labelXsmallSemibold: TextStyle(
      fontSize: 10,
      height: 1.4,
      fontWeight: FontWeight.w500,
      fontFamily: _fontFamily,
    ),
    labelTinyRegular: TextStyle(
      fontSize: 8,
      height: 1.5,
      fontWeight: FontWeight.w400,
      fontFamily: _fontFamily,
    ),
    labelTinyBold: TextStyle(
      fontSize: 8,
      height: 1.5,
      fontWeight: FontWeight.bold,
      fontFamily: _fontFamily,
    ),

    // Body系
    bodyMediumRegular: TextStyle(
      fontSize: 14,
      height: 1.43,
      fontWeight: FontWeight.w400,
      fontFamily: _fontFamily,
    ),
    bodySmallRegular: TextStyle(
      fontSize: 12,
      height: 1.5,
      fontWeight: FontWeight.w400,
      fontFamily: _fontFamily,
    ),
  );

  @override
  AppTextStyles copyWith({
    TextStyle? headingXLargeBold,
    TextStyle? headingLargeRegular,
    TextStyle? headingMediumBold,
    TextStyle? headingMediumSemibold,
    TextStyle? labelXlargeRegular,
    TextStyle? labelLargeBold,
    TextStyle? labelMediumSemibold,
    TextStyle? labelMediumRegular,
    TextStyle? labelSmallRegular,
    TextStyle? labelSmallSemibold,
    TextStyle? labelXsmallSemibold,
    TextStyle? labelTinyRegular,
    TextStyle? labelTinyBold,
    TextStyle? bodyMediumRegular,
    TextStyle? bodySmallRegular,
  }) {
    return AppTextStyles(
      headingXLargeSemiBold: headingXLargeBold ?? headingXLargeSemiBold,
      headingLargeRegular: headingLargeRegular ?? this.headingLargeRegular,
      headingMediumBold: headingMediumBold ?? this.headingMediumBold,
      headingMediumSemibold:
          headingMediumSemibold ?? this.headingMediumSemibold,

      labelXlargeRegular: labelXlargeRegular ?? this.labelXlargeRegular,
      labelLargeBold: labelLargeBold ?? this.labelLargeBold,
      labelMediumSemibold: labelMediumSemibold ?? this.labelMediumSemibold,
      labelMediumRegular: labelMediumRegular ?? this.labelMediumRegular,
      labelSmallRegular: labelSmallRegular ?? this.labelSmallRegular,
      labelSmallSemibold: labelSmallSemibold ?? this.labelSmallSemibold,
      labelXsmallSemibold: labelXsmallSemibold ?? this.labelXsmallSemibold,
      labelTinyRegular: labelTinyRegular ?? this.labelTinyRegular,
      labelTinyBold: labelTinyBold ?? this.labelTinyBold,

      bodyMediumRegular: bodyMediumRegular ?? this.bodyMediumRegular,
      bodySmallRegular: bodySmallRegular ?? this.bodySmallRegular,
    );
  }

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) {
      return this;
    }
    return AppTextStyles(
      headingXLargeSemiBold: TextStyle.lerp(
        headingXLargeSemiBold,
        other.headingXLargeSemiBold,
        t,
      )!,
      headingLargeRegular: TextStyle.lerp(
        headingLargeRegular,
        other.headingLargeRegular,
        t,
      )!,
      headingMediumBold: TextStyle.lerp(
        headingMediumBold,
        other.headingMediumBold,
        t,
      )!,
      headingMediumSemibold: TextStyle.lerp(
        headingMediumSemibold,
        other.headingMediumSemibold,
        t,
      )!,

      labelXlargeRegular: TextStyle.lerp(
        labelXlargeRegular,
        other.labelXlargeRegular,
        t,
      )!,
      labelLargeBold: TextStyle.lerp(labelLargeBold, other.labelLargeBold, t)!,
      labelMediumSemibold: TextStyle.lerp(
        labelMediumSemibold,
        other.labelMediumSemibold,
        t,
      )!,
      labelMediumRegular: TextStyle.lerp(
        labelMediumRegular,
        other.labelMediumRegular,
        t,
      )!,
      labelSmallRegular: TextStyle.lerp(
        labelSmallRegular,
        other.labelSmallRegular,
        t,
      )!,
      labelSmallSemibold: TextStyle.lerp(
        labelSmallSemibold,
        other.labelSmallSemibold,
        t,
      )!,
      labelXsmallSemibold: TextStyle.lerp(
        labelXsmallSemibold,
        other.labelXsmallSemibold,
        t,
      )!,
      labelTinyRegular: TextStyle.lerp(
        labelTinyRegular,
        other.labelTinyRegular,
        t,
      )!,
      labelTinyBold: TextStyle.lerp(labelTinyBold, other.labelTinyBold, t)!,

      bodyMediumRegular: TextStyle.lerp(
        bodyMediumRegular,
        other.bodyMediumRegular,
        t,
      )!,
      bodySmallRegular: TextStyle.lerp(
        bodySmallRegular,
        other.bodySmallRegular,
        t,
      )!,
    );
  }
}

/// BuildContextの拡張メソッドを追加して、簡単にアクセスできるように
extension AppThemeTextStylesBuildContext on BuildContext {
  AppTextStyles get textStyles => Theme.of(this).extension<AppTextStyles>()!;
}

/// テキストスタイルに色を簡単に適用するための拡張メソッド
extension TextStyleWithContextExtension on TextStyle {
  /// プライマリテキスト色を適用
  TextStyle withPrimaryTextColor(BuildContext context) {
    return copyWith(color: context.appColors.primaryText);
  }

  /// セカンダリテキスト色を適用
  TextStyle withSecondaryTextColor(BuildContext context) {
    return copyWith(color: context.appColors.secondaryText);
  }

  /// サブテキスト色を適用
  TextStyle withSubtleTextColor(BuildContext context) {
    return copyWith(color: context.appColors.subtleText);
  }

  /// emptyテキスト色を適用
  TextStyle withEmptyTextColor(BuildContext context) {
    return copyWith(color: context.appColors.emptyText);
  }

  /// surface色を適用
  TextStyle withSurfaceColor(BuildContext context) {
    return copyWith(color: context.appColors.surface);
  }

  /// プライマリカラーを適用
  TextStyle withPrimaryColor(BuildContext context) {
    return copyWith(color: context.appColors.primary);
  }

  /// エラー色を適用
  TextStyle withErrorColor(BuildContext context) {
    return copyWith(color: context.appColors.error);
  }

  /// 任意の色を適用
  TextStyle withColor(Color color) {
    return copyWith(color: color);
  }
}

/// テキストスタイルに便利な修飾を追加する拡張メソッド
extension TextStyleDecorationsExtension on TextStyle {
  /// アンダーライン付きにする
  TextStyle get underlined {
    return copyWith(decoration: TextDecoration.underline);
  }

  /// 取り消し線付きにする
  TextStyle get lineThrough {
    return copyWith(decoration: TextDecoration.lineThrough);
  }

  /// 斜体にする
  TextStyle get italic {
    return copyWith(fontStyle: FontStyle.italic);
  }

  /// 太さを指定する
  TextStyle withWeight(FontWeight weight) {
    return copyWith(fontWeight: weight);
  }

  /// サイズを変更する
  TextStyle withSize(double size) {
    return copyWith(fontSize: size);
  }

  /// 行の高さを変更する
  TextStyle withHeight(double height) {
    return copyWith(height: height);
  }

  /// 文字間隔を変更する
  TextStyle withLetterSpacing(double letterSpacing) {
    return copyWith(letterSpacing: letterSpacing);
  }
}
