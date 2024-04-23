import 'package:flutter/material.dart';

class CustomTextTheme {
  static double largeSize = 22;
  static double mediumSize = 18;
  static double normalSize = 16;
  static double smallSize = 14;
  static double extraSmallSize = 12;

  static String font = "IBM Plex Sans Thai";

  static TextStyle title = TextStyle(
    fontSize: largeSize,
    fontWeight: FontWeight.normal,
    fontFamily: font,
  );

  static TextStyle titleBold = TextStyle(
    fontSize: largeSize,
    fontWeight: FontWeight.bold,
    fontFamily: font,
  );

  static TextStyle subtitle = TextStyle(
    fontSize: mediumSize,
    fontWeight: FontWeight.normal,
    fontFamily: font,
  );

  static TextStyle subtitleBold = TextStyle(
    fontSize: mediumSize,
    fontWeight: FontWeight.bold,
    fontFamily: font,
  );

  static TextStyle body = TextStyle(
    fontSize: normalSize,
    fontWeight: FontWeight.normal,
    fontFamily: font,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: normalSize,
    fontWeight: FontWeight.w500,
    fontFamily: font,
  );

  static TextStyle bodyBold = TextStyle(
    fontSize: normalSize,
    fontWeight: FontWeight.bold,
    fontFamily: font,
  );

  static TextStyle smallBody = TextStyle(
    fontSize: smallSize,
    fontWeight: FontWeight.normal,
    fontFamily: font,
  );

  static TextStyle smallBodyMedium = TextStyle(
    fontSize: smallSize,
    fontWeight: FontWeight.w500,
    fontFamily: font,
  );

  static TextStyle smallBodyBold = TextStyle(
    fontSize: smallSize,
    fontWeight: FontWeight.bold,
    fontFamily: font,
  );

  static TextStyle description = TextStyle(
    fontSize: extraSmallSize,
    fontWeight: FontWeight.normal,
    fontFamily: font,
  );

  static TextStyle descriptionBold = TextStyle(
    fontSize: extraSmallSize,
    fontWeight: FontWeight.bold,
    fontFamily: font,
  );
}
