import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_theme.dart';
import '../core/utils/app_date.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_text_field.dart';
import '../core/widgets/priority_badge.dart';
import '../models/category_model.dart';
import '../models/note_model.dart';
import '../services/note_repository.dart';

// Halaman 4: form tambah catatan.
class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  // Kategori sama seperti filter Beranda (tanpa "Semua" & "Penting").
  static final List<CategoryModel> _categories = CategoryModel
      .defaultCategories
      .where((category) => category.id != 'all' && category.id != 'penting')
      .toList();

  String _category = _categories.first.name;
  Color _accentColor = AppColors.noteColors.first;
  NotePriority _priority = NotePriority.medium;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now();
    final content = _contentController.text.trim();

    NoteRepository().addNote(
      NoteModel(
        id: now.microsecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        content: content.isEmpty ? '(Belum ada isi catatan)' : content,
        category: _category,
        date: AppDate.short(now),
        time: AppDate.clock(now),
        priority: _priority,
        cardColor: _accentColor,
        icon: CategoryModel.iconForName(_category),
      ),
    );

    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    messenger.showSnackBar(
      const SnackBar(content: Text('Catatan tersimpan di Beranda.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        title: const Text('Tambah Catatan'),
        leading: IconButton(
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_rounded, size: 22),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          child: Form(
            key: _formKey,
            // Validasi berjalan saat mengetik.
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Judul Catatan',
                  controller: _titleController,
                  hintText: 'Contoh: Belanja besok',
                  validator: (value) =>
                      (value == null || value.trim().isEmpty)
                      ? 'Judul wajib diisi'
                      : null,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Isi Catatan',
                  controller: _contentController,
                  hintText: 'Tulis apa saja di sini...',
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 24),
                _buildCategoryField(),
                const SizedBox(height: 24),
                _buildColorField(),
                const SizedBox(height: 24),
                _buildPriorityField(),
                const SizedBox(height: 34),
                CustomButton(
                  text: 'Simpan Catatan',
                  icon: Icons.check_rounded,
                  onPressed: _save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('KATEGORI', style: AppTheme.label),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.line),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _category,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.inkSoft,
              ),
              items: _categories
                  .map(
                    (category) => DropdownMenuItem<String>(
                      value: category.name,
                      child: Row(
                        children: [
                          Icon(
                            category.icon,
                            size: 18,
                            color: AppColors.accent,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            category.name,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.ink,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _category = value);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('WARNA CATATAN', style: AppTheme.label),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: AppColors.noteColors.map((color) {
            final selected = _accentColor == color;
            return GestureDetector(
              onTap: () => setState(() => _accentColor = color),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 46,
                height: 46,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // Cincin muncul saat dipilih.
                  border: Border.all(
                    color: selected ? AppColors.accent : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.12),
                    ),
                  ),
                  child: selected
                      ? const Icon(
                          Icons.check_rounded,
                          size: 18,
                          color: AppColors.ink,
                        )
                      : null,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPriorityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('PRIORITAS', style: AppTheme.label),
        const SizedBox(height: 12),
        Row(
          children: NotePriority.values.map((priority) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: priority == NotePriority.high ? 0 : 10,
                ),
                child: PriorityBadge(
                  priority: priority,
                  isSelected: _priority == priority,
                  onTap: () => setState(() => _priority = priority),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
