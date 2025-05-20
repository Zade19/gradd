// lib/ui/theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ── brand colours ──────────────────────────────────────────────────────
const _peach      = Color(0xFFFFD8A6);
const _orange     = Color(0xFFFFA94D);
const _orangeDeep = Color(0xFFD67C1C);
const _greyText   = Color(0xFF404040);
const _bgLight    = Color(0xFFFDF9F4);

// Export a single, always-light theme
ThemeData buildAppTheme() {
  final base = ThemeData.light(useMaterial3: true);

  return base.copyWith(
    scaffoldBackgroundColor: _bgLight,
    colorScheme: base.colorScheme.copyWith(
      primary: _orange,
      secondary: _peach,
      surface: _peach,
      onPrimary: Colors.white,
      onSecondary: _greyText,
      onSurface: _greyText,
      background: _bgLight,
      onBackground: _greyText,
    ),

    // Typography
    textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).apply(
      bodyColor: _greyText,
      displayColor: _greyText,
    ),

    // App-bar
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: _greyText,
      centerTitle: true,
    ),

    // Cards
    cardTheme: CardTheme(
      color: _peach,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _orange,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2,
      ),
    ),

    // Bottom-nav
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: _orangeDeep,
      unselectedItemColor: _greyText,
      type: BottomNavigationBarType.fixed,
      elevation: 6,
    ),

    // Text-fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _peach,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
