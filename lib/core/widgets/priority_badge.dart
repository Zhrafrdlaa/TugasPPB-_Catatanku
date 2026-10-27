import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../../models/note_model.dart';

// Badge prioritas: versi label, atau versi tombol pilih saat [onTap] diisi.
class PriorityBadge extends StatelessWidget {
  const PriorityBadge({
    super.key,
    required this.priority,
    this.isSelected = false,
    this.onTap,
  });

  final NotePriority priority;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (onTap != null) return _buildSelector();
    return _buildLabel();
  }

  // Versi label kecil.
  Widget _buildLabel() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(shape: BoxShape.circle, color: priority.color),
        ),
        const SizedBox(width: 6),
        Text(
          priority.label,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: priority.color,
          ),
        ),
      ],
    );
  }

  // Versi tombol pilih untuk form.
  Widget _buildSelector() {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? priority.color.withValues(alpha: 0.13)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? priority.color : AppColors.line,
            width: isSelected ? 1.6 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: priority.color,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              priority.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? priority.color : AppColors.inkSoft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
