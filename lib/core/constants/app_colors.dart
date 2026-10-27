import 'package:flutter/material.dart';

// Palet warna CatatanKu (tema biru).
class AppColors {
  AppColors._();

  static const Color paper = Color(0xFFEDF2FA);
  static const Color surface = Color(0xFFFFFFFF);

  static const Color ink = Color(0xFF152238);
  static const Color inkSoft = Color(0xFF55637A);
  static const Color inkFaint = Color(0xFF8A97AC);

  static const Color line = Color(0xFFDCE4F0);

  static const Color accent = Color(0xFF2F6BED);
  static const Color deep = Color(0xFF16263F);

  // Warna teks bahaya (hapus).
  static const Color high = Color(0xFFD13B3B);

  // Warna catatan yang bisa dipilih.
  static const List<Color> noteColors = [
    Color(0xFFDCEAFE),
    Color(0xFFD6F0F5),
    Color(0xFFE2E5FB),
    Color(0xFFD9F0E1),
    Color(0xFFEDE4FB),
    Color(0xFFE0ECF2),
  ];
}
