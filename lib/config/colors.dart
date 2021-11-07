import 'package:flutter/material.dart';

class ThemeColors {
  ThemeColors._();

  static late Color mainColor;
  static late Color lightMainAccentColor;

  static late Color textPrimaryColor;
  static late Color textPrimaryLightColor;

  static late Color backgroundColor;
  static late Color buttonLightColor;

  static late Color progressStartColor;
  static late Color progressEndColor;

  static late Color iconColor;
  static late Color iconLightColor;

  static late Color white;
  static late Color black;
  static late Color grey;
  static late Color transparent;

  static void loadColors() {
    mainColor = const Color(0xFF272C44);
    lightMainAccentColor = const Color(0xFF8391D4);

    textPrimaryColor = const Color(0xFFD2D6EF);
    textPrimaryLightColor = const Color(0xFFD2D6EF);

    backgroundColor = const Color(0xFF3B405E);
    progressStartColor = const Color(0xFFF47169);
    progressEndColor = const Color(0xffFF8080);

    iconColor = const Color(0xFF9299C2);

    white = Colors.white;
    black = Colors.black;
    grey = Colors.grey;
    transparent = Colors.transparent;

    buttonLightColor = const Color(0xFFFFFCF2);
    iconLightColor = const Color(0xFFFFFCF2);
  }
}
