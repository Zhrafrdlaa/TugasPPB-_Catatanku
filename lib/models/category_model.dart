import 'package:flutter/material.dart';

/// Model Kategori Catatan (Konsep OOP Data Class)
class CategoryModel {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  /// Daftar kategori bawaan aplikasi
  static const List<CategoryModel> defaultCategories = [
    CategoryModel(
      id: 'all',
      name: 'Semua',
      icon: Icons.grid_view_rounded,
      color: Color(0xFF2563EB),
    ),
    CategoryModel(
      id: 'penting',
      name: 'Penting',
      icon: Icons.star_rounded,
      color: Color(0xFFF59E0B),
    ),
    CategoryModel(
      id: 'ide',
      name: 'Ide Aplikasi',
      icon: Icons.lightbulb_rounded,
      color: Color(0xFFF59E0B),
    ),
    CategoryModel(
      id: 'kerja',
      name: 'Kerja',
      icon: Icons.work_rounded,
      color: Color(0xFF0EA5E9),
    ),
    CategoryModel(
      id: 'kuliah',
      name: 'Kuliah',
      icon: Icons.school_rounded,
      color: Color(0xFF8B5CF6),
    ),
    CategoryModel(
      id: 'pribadi',
      name: 'Pribadi',
      icon: Icons.person_rounded,
      color: Color(0xFF10B981),
    ),
    CategoryModel(
      id: 'belanja',
      name: 'Belanja',
      icon: Icons.shopping_bag_rounded,
      color: Color(0xFFEC4899),
    ),
    CategoryModel(
      id: 'jurnal',
      name: 'Jurnal Harian',
      icon: Icons.favorite_rounded,
      color: Color(0xFF3B82F6),
    ),
  ];
}
