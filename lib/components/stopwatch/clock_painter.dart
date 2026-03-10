import 'package:flutter/material.dart';
import 'dart:math';

// CustomPainter untuk menggambar jam analog stopwatch di atas Canvas
class ClockPainter extends CustomPainter {
  final Duration elapsed; // Waktu berjalan — dipakai untuk menghitung posisi jarum & arc
  ClockPainter(this.elapsed);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Lingkaran luar (abu) + lingkaran dalam (putih) sebagai muka jam
    canvas.drawCircle(center, radius, Paint()..color = const Color(0xFFEEEEEE));
    canvas.drawCircle(center, radius * 0.93, Paint()..color = Colors.white);

    // Gambar 60 garis tik — setiap kelipatan 5 (jam) lebih tebal dan gelap
    final tickPaint = Paint()..strokeCap = StrokeCap.round;
    for (int i = 0; i < 60; i++) {
      final angle = (i * 6) * pi / 180; // 360° / 60 tik = 6° per tik
      final isMain = i % 5 == 0;        // Tik utama di posisi angka jam (0, 5, 10, ...)
      final outer = center + Offset(cos(angle - pi / 2), sin(angle - pi / 2)) * radius * 0.90;
      final inner = center + Offset(cos(angle - pi / 2), sin(angle - pi / 2)) * radius * (isMain ? 0.78 : 0.85);
      tickPaint
        ..color = isMain ? const Color(0xFF424242) : const Color(0xFFBDBDBD)
        ..strokeWidth = isMain ? 2.0 : 1.0;
      canvas.drawLine(inner, outer, tickPaint);
    }

    // Arc progress detik — sweep dari atas (−π/2) searah jarum jam
    final seconds = elapsed.inMilliseconds / 1000.0; // Pakai milidetik agar gerak halus
    final sweepAngle = (seconds % 60) / 60 * 2 * pi; // Modulo 60 agar reset tiap menit
    final arcPaint = Paint()
      ..color = const Color(0xFF212121)
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.90),
      -pi / 2,     // Mulai dari posisi jam 12 (atas)
      sweepAngle,
      false,
      arcPaint,
    );

    // Hitung sudut jarum detik dari sweepAngle yang sudah dihitung
    final secAngle = sweepAngle - pi / 2;
    final handPaint = Paint()
      ..color = const Color(0xFF212121)
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    // Ekor jarum (pendek, ke belakang) — abu agar kontras dengan jarum utama
    canvas.drawLine(
      center - Offset(cos(secAngle), sin(secAngle)) * radius * 0.2,
      center,
      handPaint..color = const Color(0xFF9E9E9E),
    );

    // Jarum utama (panjang, ke depan)
    canvas.drawLine(
      center,
      center + Offset(cos(secAngle), sin(secAngle)) * radius * 0.70,
      handPaint..color = const Color(0xFF212121),
    );

    // Titik pusat jarum: lingkaran hitam luar + putih dalam
    canvas.drawCircle(center, 7, Paint()..color = const Color(0xFF212121));
    canvas.drawCircle(center, 4, Paint()..color = Colors.white);
  }

  // Hanya repaint jika elapsed berubah — mencegah redraw yang tidak perlu
  @override
  bool shouldRepaint(ClockPainter old) => old.elapsed != elapsed;
}