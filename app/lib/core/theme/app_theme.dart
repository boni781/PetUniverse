import 'package:flutter/material.dart';

/// Initial theme foundation.
///
/// Brand colors, typography, spacing, and component styles are provisional
/// until the PetUniverse UI/UX design system is finalized.
abstract final class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF39796B),
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color(0xFFF7F9F8),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Color(0xFFF7F9F8),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFFE5ECE8)),
      ),
    ),
  );
}
