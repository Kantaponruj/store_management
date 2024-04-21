// Flutter imports:
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import 'package:store_management/screens/main_page.dart';
import 'package:store_management/shared/components/color_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.ibmPlexSansThaiTextTheme(),
        primaryColor: ColorTheme.primary,
        scaffoldBackgroundColor: ColorTheme.background,
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
