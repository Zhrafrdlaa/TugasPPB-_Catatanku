import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_text_field.dart';
import '../core/widgets/priority_badge.dart';
import '../models/note_model.dart';
import '../services/note_repository.dart';

/// Halaman 4: Tambah Catatan (Form Input)
/// Memfasilitasi input Judul, Isi, Kategori, Palet Warna, dan Prioritas catatan.
class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  String _selectedCategory = 'Ide Aplikasi';
  Color _selectedColor = AppColors.noteColors[0];
  NotePriority _selectedPriority = NotePriority.medium;

  final List<String> _categoryOptions = [
    'Ide Aplikasi',
    'Kerja',
    'Kuliah',
    'Belanja',
    'Jurnal Harian',
    'Pribadi',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan masukkan judul catatan'),
          backgroundColor: AppColors.priorityHigh,
        ),
      );
      return;
    }

    final newNote = NoteModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      content: _contentController.text.trim().isEmpty
          ? 'Tidak ada rincian konten.'
          : _contentController.text.trim(),
      category: _selectedCategory,
      date: 'Hari ini, 25 Okt 2026',
      time: '19.30',
      priority: _selectedPriority,
      cardColor: _selectedColor,
      icon: _getCategoryIcon(_selectedCategory),
    );

    NoteRepository().addNote(newNote);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Catatan baru berhasil disimpan! ✨'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.of(context).pop();
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Ide Aplikasi':
        return Icons.lightbulb_rounded;
      case 'Kerja':
        return Icons.work_rounded;
      case 'Kuliah':
        return Icons.school_rounded;
      case 'Belanja':
        return Icons.shopping_bag_rounded;
      case 'Jurnal Harian':
        return Icons.favorite_rounded;
      default:
        return Icons.article_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Tambah Catatan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Judul Catatan
                CustomTextField(
                  label: 'Judul Catatan',
                  controller: _titleController,
                  hintText: 'Masukkan judul catatan',
                ),
                const SizedBox(height: 20),

                // 2. Isi Catatan
                CustomTextField(
                  label: 'Isi Catatan',
                  controller: _contentController,
                  hintText: 'Tulis catatan Anda di sini...',
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 20),

                // 3. Dropdown Kategori
                const Text(
                  'Kategori',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCategory,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textMuted),
                      items: _categoryOptions.map((String cat) {
                        return DropdownMenuItem<String>(
                          value: cat,
                          child: Row(
                            children: [
                              Icon(_getCategoryIcon(cat), size: 18, color: AppColors.primary),
                              const SizedBox(width: 10),
                              Text(
                                cat,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedCategory = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 4. Pilihan Warna Catatan
                const Text(
                  'Warna Aksen Catatan',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: AppColors.noteColors.map((color) {
                    final isSelected = _selectedColor == color;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.border,
                            width: isSelected ? 2.5 : 1,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  )
                                ]
                              : null,
                        ),
                        child: isSelected
                            ? const Center(
                                child: Icon(
                                  Icons.check_rounded,
                                  size: 20,
                                  color: AppColors.primary,
                                ),
                              )
                            : null,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // 5. Pilihan Prioritas
                const Text(
                  'Prioritas',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: NotePriority.values.map((priority) {
                    final isSelected = _selectedPriority == priority;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: PriorityBadge(
                          priority: priority,
                          isSelected: isSelected,
                          onTap: () {
                            setState(() {
                              _selectedPriority = priority;
                            });
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 36),

                // 6. Tombol Simpan
                CustomButton(
                  text: 'Simpan Catatan',
                  icon: Icons.save_rounded,
                  onPressed: _saveNote,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
