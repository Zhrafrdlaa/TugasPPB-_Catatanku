import 'package:flutter/material.dart';

// Kategori untuk filter catatan di Beranda.
class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  final String id;
  final String name;
  final IconData icon;

  static const List<CategoryModel> defaultCategories = [
    CategoryModel(id: 'all', name: 'Semua', icon: Icons.grid_view_rounded),
    CategoryModel(id: 'penting', name: 'Penting', icon: Icons.star_rounded),
    CategoryModel(
      id: 'ide',
      name: 'Ide Aplikasi',
      icon: Icons.lightbulb_rounded,
    ),
    CategoryModel(id: 'kerja', name: 'Kerja', icon: Icons.work_rounded),
    CategoryModel(id: 'kuliah', name: 'Kuliah', icon: Icons.school_rounded),
    CategoryModel(id: 'pribadi', name: 'Pribadi', icon: Icons.person_rounded),
    CategoryModel(
      id: 'belanja',
      name: 'Belanja',
      icon: Icons.shopping_bag_rounded,
    ),
    CategoryModel(
      id: 'jurnal',
      name: 'Jurnal Harian',
      icon: Icons.favorite_rounded,
    ),
  ];

  // Cari ikon berdasarkan nama kategori.
  static IconData iconForName(String name) {
    for (final category in defaultCategories) {
      if (category.name.toLowerCase() == name.toLowerCase()) {
        return category.icon;
      }
    }
    return Icons.article_rounded;
  }
}
