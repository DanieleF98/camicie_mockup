import 'package:camicie_mockup/utils/colors.dart';
import 'package:flutter/material.dart';

const TextStyle baseTextStyle = TextStyle(fontSize: 15);
TextStyle boldTextStyle = baseTextStyle.copyWith(fontWeight: FontWeight.bold);

const TextStyle appBarLightTextStyle = TextStyle(
  color: primaryDarkColor,
  fontSize: 25,
  fontWeight: FontWeight.bold,
);
const IconThemeData iconLightData = IconThemeData(color: primaryDarkColor);
const TextStyle elevatedButtonTextLightStyle = TextStyle(
  color: primaryDarkColor,
  fontSize: 42,
  fontWeight: FontWeight.bold,
);

const TextStyle appBarDarkTextStyle = TextStyle(
  color: primaryLightColor,
  fontSize: 25,
  fontWeight: FontWeight.bold,
);
const IconThemeData iconDarkData = IconThemeData(color: primaryLightColor);
const TextStyle elevatedButtonTextDarkStyle = TextStyle(
  color: primaryLightColor,
  fontSize: 42,
  fontWeight: FontWeight.bold,
);
