import 'package:flutter/material.dart';

// Level prioritas, lengkap dengan label & warna.
enum NotePriority {
  low('Rendah', Color(0xFF2F855A)),
  medium('Sedang', Color(0xFFB45309)),
  high('Tinggi', Color(0xFFB91C1C));

  const NotePriority(this.label, this.color);

  final String label;
  final Color color;
}

// Model satu catatan. Field final (tidak ada edit, hanya tambah & hapus).
class NoteModel {
  const NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.date,
    required this.time,
    required this.priority,
    required this.cardColor,
    this.icon = Icons.edit_note_rounded,
  });

  final String id;
  final String title;
  final String content;
  final String category;
  final String date;
  final String time;
  final NotePriority priority;
  final Color cardColor;
  final IconData icon;
}
