import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CineTheme {
  static const Color backgroundBlack = Color(0xFF141414);
  static const Color surfaceGray = Color(0xFF2F2F2F);
  static const Color cinematicRed = Color(0xFFE50914);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB3B3B3);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color.fromARGB(255, 32, 32, 32),
      primaryColor: cinematicRed,

      colorScheme: ColorScheme.dark(
        primary: cinematicRed,
        secondary: cinematicRed,
        surface: surfaceGray,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: backgroundBlack,
        titleTextStyle: GoogleFonts.sekuya().copyWith(color: cinematicRed),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textPrimary),
      ),

      textTheme: TextTheme(
        displayLarge: GoogleFonts.bebasNeue(
          color: textPrimary,
          fontSize: 48,
          letterSpacing: 2.0,
        ),
        titleLarge: GoogleFonts.bebasNeue(
          color: textPrimary,
          fontSize: 24,
          letterSpacing: 1.2,
        ),
        bodyLarge: GoogleFonts.inter(
          color: textSecondary,
          fontSize: 16,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(color: textPrimary, fontSize: 14),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: cinematicRed,
        foregroundColor: Colors.white,
      ),
    );
  }
}
