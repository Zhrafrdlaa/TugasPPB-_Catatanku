import 'package:flutter/material.dart';

/// Kelas utilitas warna terpusat (OOP Singleton / Constant Bag)
/// Memastikan konsistensi tampilan di seluruh halaman aplikasi CatatanKu.
class AppColors {
  AppColors._(); // Private constructor agar tidak bisa di-instansiasi

  // Primary Brand Colors
  static const Color primary = Color(0xFF2563EB); // Royal Blue Modern
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color secondary = Color(0xFF0EA5E9); // Sky Blue Accent
  static const Color accent = Color(0xFF6366F1); // Indigo

  // Background & Surface
  static const Color background = Color(0xFFF8FAFC); // Slate 50
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9); // Slate 100

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900
  static const Color textSecondary = Color(0xFF475569); // Slate 600
  static const Color textMuted = Color(0xFF94A3B8); // Slate 400
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Border & Dividers
  static const Color border = Color(0xFFE2E8F0); // Slate 200
  static const Color borderFocused = Color(0xFF3B82F6);

  // Priority Colors
  static const Color priorityLow = Color(0xFF10B981); // Emerald Green
  static const Color priorityLowBg = Color(0xFFECFDF5);
  static const Color priorityMedium = Color(0xFFF59E0B); // Amber Orange
  static const Color priorityMediumBg = Color(0xFFFFFBEB);
  static const Color priorityHigh = Color(0xFFEF4444); // Red Coral
  static const Color priorityHighBg = Color(0xFFFEF2F2);

  // Note Note Color Palettes (Dapat dipilih pengguna saat menambah catatan)
  static const List<Color> noteColors = [
    Color(0xFFFEF3C7), // Warm Yellow
    Color(0xFFD1FAE5), // Soft Mint
    Color(0xFFE0E7FF), // Soft Indigo
    Color(0xFFFCE7F3), // Soft Rose
    Color(0xFFEDE9FE), // Soft Lavender
    Color(0xFFE0F2FE), // Soft Sky
  ];

  static const List<Color> noteBorderColors = [
    Color(0xFFF59E0B),
    Color(0xFF10B981),
    Color(0xFF6366F1),
    Color(0xFFEC4899),
    Color(0xFF8B5CF6),
    Color(0xFF0EA5E9),
  ];
}
