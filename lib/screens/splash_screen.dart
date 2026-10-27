import 'dart:async';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'login_screen.dart';

// Halaman 1: splash, lalu otomatis ke Login.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const Duration _hold = Duration(milliseconds: 2500);

  late final AnimationController _anim = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..forward();

  late final Animation<double> _fade = CurvedAnimation(
    parent: _anim,
    curve: Curves.easeOut,
  );

  late final Animation<Offset> _slide = Tween<Offset>(
    begin: const Offset(0, 0.12),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeOutCubic));

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(_hold, _goToLogin);
  }

  void _goToLogin() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep,
      body: Stack(
        children: [
          // Lingkaran hiasan latar.
          Positioned(
            top: -90,
            right: -70,
            child: _blob(230, 0.06),
          ),
          Positioned(
            bottom: 120,
            left: -110,
            child: _blob(260, 0.04),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(flex: 5),
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.auto_stories_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 26),
                      const Text(
                        'CatatanKu',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1.2,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(width: 46, height: 3, color: AppColors.accent),
                      const SizedBox(height: 16),
                      const Text(
                        'Aplikasi catatan harian.\nTulis saja dulu, rapikan nanti.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.55,
                          color: Colors.white70,
                        ),
                      ),
                      const Spacer(flex: 3),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: _anim.value,
                          minHeight: 3,
                          backgroundColor: Colors.white24,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'v1.0',
                            style: TextStyle(
                              fontSize: 11.5,
                              letterSpacing: 0.6,
                              color: Colors.white38,
                            ),
                          ),
                          TextButton(
                            onPressed: _goToLogin,
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(44, 36),
                            ),
                            child: const Text(
                              'Lewati',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _blob(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacity),
      ),
    );
  }
}
