import 'package:flutter/material.dart';

/// Enum Prioritas Catatan (OOP Enum dengan helper method)
enum NotePriority {
  low('Rendah', Color(0xFF10B981), Color(0xFFECFDF5)),
  medium('Sedang', Color(0xFFF59E0B), Color(0xFFFFFBEB)),
  high('Tinggi', Color(0xFFEF4444), Color(0xFFFEF2F2));

  final String label;
  final Color color;
  final Color bgColor;

  const NotePriority(this.label, this.color, this.bgColor);
}

/// Model Entitas Catatan (Konsep OOP Data Encapsulation)
class NoteModel {
  final String id;
  final String title;
  final String content;
  final String category;
  final String date;
  final String time;
  final NotePriority priority;
  final Color cardColor;
  final IconData icon;

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

  /// Clone method untuk immutability pattern
  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    String? category,
    String? date,
    String? time,
    NotePriority? priority,
    Color? cardColor,
    IconData? icon,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      date: date ?? this.date,
      time: time ?? this.time,
      priority: priority ?? this.priority,
      cardColor: cardColor ?? this.cardColor,
      icon: icon ?? this.icon,
    );
  }
}
