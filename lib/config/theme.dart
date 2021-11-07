import 'package:flutter/material.dart';
import 'colors.dart';
import 'config.dart';

ThemeData themeData(ThemeData baseTheme) {
  ThemeColors.loadColors();
  return baseTheme.copyWith(
    primaryColor: ThemeColors.mainColor,
    backgroundColor: ThemeColors.backgroundColor,
    scaffoldBackgroundColor: ThemeColors.backgroundColor,
    textTheme: TextTheme(
      headline1: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
      ),
      headline2: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
      ),
      headline3: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
      ),
      headline4: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
      ),
      headline5: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
      ),
      subtitle1: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
        fontWeight: FontWeight.bold,
      ),
      subtitle2: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
      ),
      bodyText2: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
        fontWeight: FontWeight.bold,
      ),
      button: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
      ),
      caption: TextStyle(
        color: ThemeColors.textPrimaryLightColor,
        fontFamily: Config.defaultFontFamily,
      ),
      overline: TextStyle(
        color: ThemeColors.textPrimaryColor,
        fontFamily: Config.defaultFontFamily,
      ),
    ),
    iconTheme: IconThemeData(
      color: ThemeColors.iconColor,
    ),
    appBarTheme: AppBarTheme(
      color: ThemeColors.backgroundColor,
    ),
  );
}
