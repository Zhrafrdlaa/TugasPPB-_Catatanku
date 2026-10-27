import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

// Tombol "Masuk dengan Google". Baru tampilan, belum ke layanan autentikasi.
class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.line),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: const SizedBox(
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 22,
                height: 22,
                child: CustomPaint(painter: GoogleLogoPainter()),
              ),
              SizedBox(width: 12),
              Text(
                'Masuk dengan Google',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F3B73),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Logo Google digambar dengan canvas supaya tidak perlu file gambar.
class GoogleLogoPainter extends CustomPainter {
  const GoogleLogoPainter();

  static const Color _red = Color(0xFFEA4335);
  static const Color _yellow = Color(0xFFFBBC05);
  static const Color _green = Color(0xFF34A853);
  static const Color _blue = Color(0xFF4285F4);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.36;
    final stroke = size.width * 0.22;
    final ring = Rect.fromCircle(center: center, radius: radius);

    Paint line(Color color) {
      return Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..color = color;
    }

    // Cincin dibuka di kanan-atas, itu celah huruf G. Sudut dalam radian.
    canvas.drawArc(ring, -2.45, 1.60, false, line(_red)); // atas
    canvas.drawArc(ring, -0.25, 1.20, false, line(_blue)); // kanan
    canvas.drawArc(ring, 0.95, 1.50, false, line(_green)); // bawah
    canvas.drawArc(ring, 2.45, 1.38, false, line(_yellow)); // kiri

    // Palang dari titik tengah sampai tepi kanan cincin.
    canvas.drawRect(
      Rect.fromLTWH(
        center.dx,
        center.dy - stroke / 2,
        radius + stroke / 2,
        stroke,
      ),
      Paint()..color = _blue,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
