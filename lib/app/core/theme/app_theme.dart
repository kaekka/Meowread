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
        background: const Color(0xFFF9F5F1), // Latar belakang utama
        surface: Colors.white, // Warna kartu, dialog, dll.
        onBackground: Colors.black87, // Warna teks di atas background
        onSurface: Colors.black87, // Warna teks di atas kartu
      ),
      scaffoldBackgroundColor: const Color(0xFFF9F5F1),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white, // Warna ikon dan judul di AppBar
        elevation: 0,
      ),
      cardTheme: baseTheme.cardTheme.copyWith(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme).apply(bodyColor: Colors.black87, displayColor: Colors.black87),
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
        background: const Color(0xFF121212), // Latar belakang utama gelap
        surface: const Color(0xFF1E1E1E), // Warna kartu, dialog, dll. gelap
        onBackground: Colors.white70, // Warna teks di atas background gelap
        onSurface: Colors.white70, // Warna teks di atas kartu gelap
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white, // Warna ikon dan judul di AppBar
        elevation: 0,
      ),
      cardTheme: baseTheme.cardTheme.copyWith(
        color: const Color(0xFF1E1E1E),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme).apply(bodyColor: Colors.white70, displayColor: Colors.white70),
      primaryTextTheme: GoogleFonts.poppinsTextTheme(baseTheme.primaryTextTheme),
    );
  }
}
