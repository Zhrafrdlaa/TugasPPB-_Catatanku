import 'package:flutter_test/flutter_test.dart';
import 'package:catatanku/main.dart';

void main() {
  testWidgets('Memverifikasi Splash Screen CatatanKu berhasil dimuat', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CatatanKuApp());

    // Verify that CatatanKu title is present
    expect(find.text('CatatanKu'), findsWidgets);
  });
}
