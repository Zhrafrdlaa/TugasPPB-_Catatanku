import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Jenis varian tombol yang dapat digunakan kembali (OOP Reusable Component)
enum ButtonVariant { primary, secondary, outline, google }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final IconData? icon;
  final bool isFullWidth;
  final double height;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.isFullWidth = true,
    this.height = 50.0,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget buttonContent;

    if (isLoading) {
      buttonContent = const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      buttonContent = Row(
        mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (variant == ButtonVariant.google) ...[
            _buildGoogleIcon(),
            const SizedBox(width: 12),
          ] else if (icon != null) ...[
            Icon(icon, size: 18),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
              color: _getTextColor(),
            ),
          ),
        ],
      );
    }

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: _getBackgroundColor(),
      foregroundColor: _getTextColor(),
      elevation: variant == ButtonVariant.primary ? 1 : 0,
      shadowColor: AppColors.primary.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: _getBorderSide(),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
    );

    final widget = SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: isLoading ? null : onPressed,
        child: buttonContent,
      ),
    );

    return widget;
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case ButtonVariant.primary:
        return AppColors.primary;
      case ButtonVariant.secondary:
        return AppColors.surfaceVariant;
      case ButtonVariant.outline:
        return Colors.transparent;
      case ButtonVariant.google:
        return AppColors.surface;
    }
  }

  Color _getTextColor() {
    switch (variant) {
      case ButtonVariant.primary:
        return Colors.white;
      case ButtonVariant.secondary:
        return AppColors.textPrimary;
      case ButtonVariant.outline:
        return AppColors.primary;
      case ButtonVariant.google:
        return AppColors.textPrimary;
    }
  }

  BorderSide _getBorderSide() {
    switch (variant) {
      case ButtonVariant.outline:
        return const BorderSide(color: AppColors.primary, width: 1.5);
      case ButtonVariant.google:
        return const BorderSide(color: AppColors.border, width: 1.2);
      default:
        return BorderSide.none;
    }
  }

  Widget _buildGoogleIcon() {
    return Container(
      width: 22,
      height: 22,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Styled Google G symbol using Material icons & color
          Text(
            'G',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: [
                    Color(0xFFEA4335), // Red
                    Color(0xFFFBBC05), // Yellow
                    Color(0xFF34A853), // Green
                    Color(0xFF4285F4), // Blue
                  ],
                ).createShader(const Rect.fromLTWH(0.0, 0.0, 20.0, 20.0)),
            ),
          ),
        ],
      ),
    );
  }
}
