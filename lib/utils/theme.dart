import 'package:camicie_mockup/utils/colors.dart';
import 'package:camicie_mockup/utils/style.dart';
import 'package:flutter/material.dart';

const AppBarTheme appBarLightTheme = AppBarTheme(
  backgroundColor: appBarLightColor,
  shadowColor: shadowAppBarLightColor,
  iconTheme: iconLightData,
  titleTextStyle: appBarLightTextStyle,
);

const AppBarTheme appBarDarkTheme = AppBarTheme(
  backgroundColor: appBarDarkColor,
  shadowColor: shadowAppBarDarkColor,
  iconTheme: iconDarkData,
  titleTextStyle: appBarDarkTextStyle,
);

final ThemeData themeData = ThemeData(
  primaryColor: primaryLightColor,
  iconTheme: const IconThemeData(color: primaryDarkColor),
  scaffoldBackgroundColor: scaffoldLightColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(primaryDarkColor),
      textStyle: MaterialStateProperty.all(elevatedButtonTextLightStyle),
      backgroundColor: MaterialStateProperty.all(
        buttonsLightColor,
      ),
    ),
  ),
  cardColor: buttonsLightColor,
  dialogBackgroundColor: scaffoldLightColor,
  brightness: Brightness.light,
  appBarTheme: appBarLightTheme,
);

final ThemeData darkThemeData = ThemeData(
  primaryColor: primaryDarkColor,
  iconTheme: const IconThemeData(color: primaryLightColor),
  scaffoldBackgroundColor: scaffoldDarkColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(primaryLightColor),
      textStyle: MaterialStateProperty.all(elevatedButtonTextDarkStyle),
      backgroundColor: MaterialStateProperty.all(
        buttonsDarkColor,
      ),
    ),
  ),
  cardColor: buttonsDarkColor,
  dialogBackgroundColor: scaffoldDarkColor,
  brightness: Brightness.dark,
  appBarTheme: appBarDarkTheme,
);
