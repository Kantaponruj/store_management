import 'package:flutter/material.dart';
import 'package:store_management/constants/constant.dart';

class CustomTextTheme {
  static double extraLargeSize = isPhone ? 26 : 30;
  static double largeSize = isPhone ? 20 : 22;
  static double mediumSize = isPhone ? 16 : 18;
  static double normalSize = isPhone ? 14 : 16;
  static double smallSize = isPhone ? 12 : 14;
  static double extraSmallSize = isPhone ? 10 : 12;

  static String font = "IBM Plex Sans Thai";

  static TextStyle title = TextStyle(
    fontSize: largeSize,
    fontWeight: FontWeight.normal,
    fontFamily: font,
  );

  static TextStyle titleMedium = TextStyle(
    fontSize: largeSize,
    fontWeight: FontWeight.w500,
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

class CustomText {
  final String text;
  final TextStyle? style;

  CustomText({required this.text, this.style});
}

Widget buildFittedText({
  required CustomText textObject,
}) {
  return FittedBox(
    child: Text(
      textObject.text,
      style: textObject.style ?? CustomTextTheme.body,
    ),
  );
}
