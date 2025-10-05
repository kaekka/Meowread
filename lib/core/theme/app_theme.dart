import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final baseTheme = ThemeData.light();
    return baseTheme.copyWith(
      brightness: Brightness.light,
      primaryColor: Colors.brown,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.brown,
        brightness: Brightness.light,
        background: const Color(0xFFF9F5F1),
      ),
      scaffoldBackgroundColor: const Color(0xFFF9F5F1),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: baseTheme.cardTheme.copyWith(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
      primaryTextTheme: GoogleFonts.poppinsTextTheme(baseTheme.primaryTextTheme),
    );
  }

  static ThemeData get darkTheme {
    final baseTheme = ThemeData.dark();
    return baseTheme.copyWith(
      brightness: Brightness.dark,
      primaryColor: Colors.brown,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.brown,
        brightness: Brightness.dark,
        background: Colors.grey[900],
        surface: Colors.grey[800],
      ),
      scaffoldBackgroundColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[850],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: baseTheme.cardTheme.copyWith(
        color: Colors.grey[800],
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
      primaryTextTheme: GoogleFonts.poppinsTextTheme(baseTheme.primaryTextTheme),
    );
  }
}
