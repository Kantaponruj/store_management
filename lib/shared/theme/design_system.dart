import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_theme.dart';

ThemeData designSystem = ThemeData(
  textTheme: GoogleFonts.ibmPlexSansThaiTextTheme(),
  primaryColor: ColorTheme.primary,
  scaffoldBackgroundColor: const Color.fromRGBO(242, 242, 242, 1),
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: ColorTheme.primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: ColorTheme.background),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: ColorTheme.disabled),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: ColorTheme.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: ColorTheme.error),
    ),
  ),
);
