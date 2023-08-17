import 'package:flutter/material.dart';

/// Use as:
/// Text("Hello!", styles: MyTextStyles.title.large.white);
class MyTextStyles {
  MyTextStyles._();

  static const fontFamily = "Noto_Sans_JP";

  static _toStyle(double fontSize, double height, FontWeight fontWeight,
      double letterSpacing,
      {Color color = MyColors.black}) {
    return TextStyle(
      fontFamily: MyTextStyles.fontFamily,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    );
  }

  static final title = _MyTextStyleSet(
    large: _toStyle(22, 28, FontWeight.w400, 0),
    medium: _toStyle(16, 24, FontWeight.w500, 0.15),
    small: _toStyle(14, 20, FontWeight.w500, 0.1),
  );

  static final label = _MyTextStyleSet(
    large: _toStyle(14, 20, FontWeight.w500, 0.1),
    medium: _toStyle(12, 16, FontWeight.w500, 0.5),
    small: _toStyle(11, 16, FontWeight.w500, 0.5),
  );

  static final body = _MyTextStyleSet(
    large: _toStyle(16, 24, FontWeight.w400, 0.15),
    medium: _toStyle(14, 20, FontWeight.w400, 0.25),
    small: _toStyle(12, 16, FontWeight.w400, 0.4),
  );
}

/// Wrapper for TextStyle
class _MyTextStyle extends TextStyle {
  _MyTextStyle(TextStyle style)
      : super(
    color: style.color,
    backgroundColor: style.backgroundColor,
    fontSize: style.fontSize,
    fontWeight: style.fontWeight,
    fontStyle: style.fontStyle,
    letterSpacing: style.letterSpacing,
    wordSpacing: style.wordSpacing,
    textBaseline: style.textBaseline,
    height: style.height,
    leadingDistribution: style.leadingDistribution,
    locale: style.locale,
    foreground: style.foreground,
    background: style.background,
    shadows: style.shadows,
    fontFeatures: style.fontFeatures,
    decoration: style.decoration,
    decorationColor: style.decorationColor,
    decorationStyle: style.decorationStyle,
    decorationThickness: style.decorationThickness,
    debugLabel: style.debugLabel,
    overflow: style.overflow,
  );

  _MyTextStyle get black => _MyTextStyle(copyWith(color: MyColors.black));
  _MyTextStyle get white => _MyTextStyle(copyWith(color: MyColors.white));
  _MyTextStyle get caution => _MyTextStyle(copyWith(color: MyColors.caution));
  _MyTextStyle get grey => _MyTextStyle(copyWith(color: MyColors.grey));

  _MyTextStyle get bold => _MyTextStyle(copyWith(fontWeight: FontWeight.w700));
}

class _MyTextStyleSet extends _MyTextStyle {
  final _MyTextStyle large;
  // medium is this
  final _MyTextStyle small;

  _MyTextStyleSet(
      {required TextStyle large,
        required TextStyle medium,
        required TextStyle small})
      : large = _MyTextStyle(large),
        small = _MyTextStyle(small),
        super(medium);
}

class MyColors {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color caution = Color(0xFFFF0000);
  static const Color grey = Color(0xFFB4B4B4);
// 他のカスタムカラーもここに追加できます
}