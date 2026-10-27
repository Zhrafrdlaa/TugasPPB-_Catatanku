import 'package:flutter/material.dart';
import '../../models/note_model.dart';

/// Reusable Badge Prioritas (OOP Component)
class PriorityBadge extends StatelessWidget {
  final NotePriority priority;
  final bool isSelected;
  final VoidCallback? onTap;

  const PriorityBadge({
    super.key,
    required this.priority,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? priority.color : priority.bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: priority.color.withValues(alpha: isSelected ? 1.0 : 0.4),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.white : priority.color,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            priority.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : priority.color,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: content,
      );
    }

    return content;
  }
}
