import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_theme.dart';

// Kolom input yang dipakai ulang. Toggle hide/show sandi diatur di dalam widget.
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    required this.hintText,
    this.prefixIcon,
    this.isPassword = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  final TextEditingController? controller;
  final String? label;
  final String hintText;
  final IconData? prefixIcon;
  final bool isPassword;
  final int maxLines;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!.toUpperCase(), style: AppTheme.label),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscured : false,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          style: const TextStyle(fontSize: 14.5, color: AppColors.ink),
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: AppColors.inkFaint, size: 20)
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    tooltip: _obscured ? 'Tampilkan' : 'Sembunyikan',
                    icon: Icon(
                      _obscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.inkFaint,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _obscured = !_obscured),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
