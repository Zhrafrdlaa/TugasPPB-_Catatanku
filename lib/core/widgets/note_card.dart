import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../../models/note_model.dart';

// Kartu catatan di grid Beranda. Isi tidak ditampilkan, hanya terbaca di Detail.
class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
  });

  final NoteModel note;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: note.cardColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black.withValues(alpha: 0.07)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Penanda prioritas
                Container(height: 5, color: note.priority.color),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(13, 12, 13, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(note.icon, size: 17, color: AppColors.accent),
                            const SizedBox(width: 7),
                            Expanded(
                              child: Text(
                                note.category.toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.9,
                                  color: AppColors.inkSoft,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          note.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
                            color: AppColors.ink,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          note.date,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.inkSoft,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
