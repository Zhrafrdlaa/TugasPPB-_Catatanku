import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_theme.dart';
import '../core/widgets/priority_badge.dart';
import '../models/note_model.dart';
import '../services/note_repository.dart';

// Halaman 5: detail satu catatan.
class DetailNoteScreen extends StatelessWidget {
  const DetailNoteScreen({super.key, required this.note});

  final NoteModel note;

  void _confirmDelete(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Hapus catatan ini?',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Judul "${note.title}" akan hilang dari daftar.',
          style: const TextStyle(fontSize: 13.5, color: AppColors.inkSoft),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              final messenger = ScaffoldMessenger.of(context);
              Navigator.of(dialogContext).pop();
              NoteRepository().deleteNote(note.id);
              Navigator.of(context).pop();
              messenger.showSnackBar(
                const SnackBar(content: Text('Catatan dihapus.')),
              );
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: AppColors.high, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        title: const Text('Detail Catatan'),
        leading: IconButton(
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_rounded, size: 22),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            tooltip: 'Hapus catatan',
            icon: const Icon(Icons.delete_outline_rounded, size: 22),
            color: AppColors.high,
            onPressed: () => _confirmDelete(context),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 6, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 22),
              const Text('ISI CATATAN', style: AppTheme.label),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.line),
                ),
                child: SelectableText(
                  note.content,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.7,
                    color: AppColors.ink,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: note.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.07)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(note.icon, size: 21, color: AppColors.accent),
              ),
              const Spacer(),
              PriorityBadge(priority: note.priority),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            note.title,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            note.category.toUpperCase(),
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.9,
              color: AppColors.inkSoft,
            ),
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Colors.black12),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.schedule_rounded,
                size: 14,
                color: AppColors.inkSoft,
              ),
              const SizedBox(width: 7),
              Text(
                '${note.date}  •  ${note.time} WIB',
                style: const TextStyle(fontSize: 12.5, color: AppColors.inkSoft),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
