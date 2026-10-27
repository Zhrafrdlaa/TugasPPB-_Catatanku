import 'package:flutter/material.dart';
import 'app_colors.dart';

// Tema & style yang dipakai semua halaman.
class AppTheme {
  AppTheme._();

  // Label kecil untuk judul seksi / form.
  static const TextStyle label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.1,
    color: AppColors.inkFaint,
  );

  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.6,
    color: AppColors.ink,
  );

  static const TextStyle subHeading = TextStyle(
    fontSize: 13.5,
    fontWeight: FontWeight.w500,
    color: AppColors.inkSoft,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        primary: AppColors.accent,
        surface: AppColors.surface,
        error: AppColors.high,
      ),
      scaffoldBackgroundColor: AppColors.paper,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.paper,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: 4,
        iconTheme: IconThemeData(color: AppColors.ink),
        titleTextStyle: TextStyle(
          color: AppColors.ink,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.deep,
        contentTextStyle: TextStyle(color: Colors.white, fontSize: 13.5),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        hintStyle: const TextStyle(color: AppColors.inkFaint, fontSize: 14),
        border: _fieldBorder(AppColors.line),
        enabledBorder: _fieldBorder(AppColors.line),
        focusedBorder: _fieldBorder(AppColors.accent, width: 1.6),
        errorBorder: _fieldBorder(AppColors.high),
        focusedErrorBorder: _fieldBorder(AppColors.high, width: 1.6),
      ),
    );
  }

  static OutlineInputBorder _fieldBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
