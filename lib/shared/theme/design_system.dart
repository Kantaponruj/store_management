import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_management/shared/theme/text_theme.dart';

import 'color_theme.dart';

enum ColorType { primary, secondary, disabled, error, success }

Map<ColorType, Color> getColors = {
  ColorType.primary: ColorTheme.primary,
  ColorType.secondary: ColorTheme.secondary,
  ColorType.disabled: ColorTheme.disabled,
  ColorType.error: ColorTheme.error,
  ColorType.success: ColorTheme.success,
};

ThemeData designSystem = ThemeData(
  textTheme: GoogleFonts.ibmPlexSansThaiTextTheme(),
  primaryColor: ColorTheme.primary,
  scaffoldBackgroundColor: const Color.fromRGBO(242, 242, 242, 1),
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: ColorTheme.primary,
  ),
  primaryTextTheme: const TextTheme(),
  appBarTheme: AppBarTheme(
    backgroundColor: ColorTheme.primary,
    foregroundColor: ColorTheme.white,
    titleTextStyle: CustomTextTheme.titleBold,
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: ColorTheme.background,
    surfaceTintColor: Colors.transparent,
  ),
  inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: getColors[ColorType.disabled]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: getColors[ColorType.disabled]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: getColors[ColorType.primary]!, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: getColors[ColorType.error]!),
      ),
      prefixIconColor:
          MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return getColors[ColorType.primary]!;
        }
        if (states.contains(MaterialState.error)) {
          return getColors[ColorType.error]!;
        }
        return getColors[ColorType.disabled]!;
      })),
);
