import 'package:flutter/material.dart';
import 'core/constants/app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CatatanKuApp());
}

/// Root Widget Aplikasi CatatanKu
/// Menggunakan konsep OOP State dan StatelessWidget yang rapi serta modular.
class CatatanKuApp extends StatelessWidget {
  const CatatanKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatatanKu',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
