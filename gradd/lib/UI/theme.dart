import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _peach     = Color(0xFFFFD8A6);
const _peachDark = Color(0xFFF7C288);
const _orange    = Color(0xFFFFA94D);
const _orangeDeep= Color(0xFFD67C1C);
const _greyText  = Color(0xFF404040);
const _bg        = Color(0xFFFDF9F4);

ThemeData buildAppTheme() {
  final base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    scaffoldBackgroundColor: _bg,
    colorScheme: base.colorScheme.copyWith(
      primary: _orange,
      secondary: _peach,
      surface: _peach,
      onPrimary: Colors.white,
      onSecondary: _greyText,
      onSurface: _greyText,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).copyWith(
      titleLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.w600, color: _greyText),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: _greyText,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      color: _peach,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _orange,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        elevation: 2,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: _orangeDeep,
      unselectedItemColor: _greyText,
      type: BottomNavigationBarType.fixed,
      elevation: 6,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _peach,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  );
}

ThemeData buildDarkTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: const Color(0xFFFFA94D),
      secondary: const Color(0xFFF7C288),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
  );
}
