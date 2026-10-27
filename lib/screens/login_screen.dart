import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_theme.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_text_field.dart';
import '../core/widgets/google_button.dart';
import 'home_screen.dart';

// Halaman 2: login
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  // Tombol Google belum terhubung ke layanan asli, hanya memunculkan pesan.
  void _signInWithGoogle() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pembuatan akun dengan Google segera hadir'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 34),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 48),
                    Center(
                      child: Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accent.withValues(alpha: 0.25),
                              blurRadius: 22,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.auto_stories_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Center(
                      child: Text('CatatanKu', style: AppTheme.heading),
                    ),
                    const SizedBox(height: 46),
                    CustomTextField(
                      label: 'Email',
                      controller: _emailController,
                      hintText: 'masukkan email',
                      prefixIcon: Icons.alternate_email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 18),
                    CustomTextField(
                      label: 'Kata Sandi',
                      controller: _passwordController,
                      hintText: 'masukkan kata sandi',
                      prefixIcon: Icons.lock_outline_rounded,
                      isPassword: true,
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: 'Masuk',
                      isLoading: _isLoading,
                      onPressed: _submit,
                    ),
                    const SizedBox(height: 26),
                    _buildOrDivider(),
                    const SizedBox(height: 26),
                    GoogleButton(
                      onPressed: _isLoading ? null : _signInWithGoogle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Pemisah "atau" di antara tombol Masuk dan tombol Google.
  Widget _buildOrDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.line)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'atau',
            style: const TextStyle(fontSize: 12.5, color: AppColors.inkSoft),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.line)),
      ],
    );
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Email belum diisi';
    if (!email.contains('@')) return 'Format email belum benar';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Kata sandi minimal 6 karakter';
    }
    return null;
  }
}
