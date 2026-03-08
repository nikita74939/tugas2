import 'package:flutter/material.dart';
import 'dart:math';

class ClockPainter extends CustomPainter {
  final Duration elapsed;
  ClockPainter(this.elapsed);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background circle — white with subtle shadow via outer ring
    canvas.drawCircle(
      center,
      radius,
      Paint()..color = const Color(0xFFEEEEEE),
    );
    canvas.drawCircle(
      center,
      radius * 0.93,
      Paint()..color = Colors.white,
    );

    // Tick marks
    final tickPaint = Paint()..strokeCap = StrokeCap.round;
    for (int i = 0; i < 60; i++) {
      final angle = (i * 6) * pi / 180;
      final isMain = i % 5 == 0;
      final outer = center + Offset(cos(angle - pi / 2), sin(angle - pi / 2)) * radius * 0.90;
      final inner = center + Offset(cos(angle - pi / 2), sin(angle - pi / 2)) * radius * (isMain ? 0.78 : 0.85);
      tickPaint
        ..color = isMain ? const Color(0xFF424242) : const Color(0xFFBDBDBD)
        ..strokeWidth = isMain ? 2.0 : 1.0;
      canvas.drawLine(inner, outer, tickPaint);
    }

    // Progress arc (seconds)
    final seconds = elapsed.inMilliseconds / 1000.0;
    final sweepAngle = (seconds % 60) / 60 * 2 * pi;
    final arcPaint = Paint()
      ..color = const Color(0xFF212121)
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.90),
      -pi / 2,
      sweepAngle,
      false,
      arcPaint,
    );

    // Second hand
    final secAngle = sweepAngle - pi / 2;
    final handPaint = Paint()
      ..color = const Color(0xFF212121)
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;
    // Tail
    canvas.drawLine(
      center - Offset(cos(secAngle), sin(secAngle)) * radius * 0.2,
      center,
      handPaint..color = const Color(0xFF9E9E9E),
    );
    // Hand
    canvas.drawLine(
      center,
      center + Offset(cos(secAngle), sin(secAngle)) * radius * 0.70,
      handPaint..color = const Color(0xFF212121),
    );

    // Center dot — outer ring
    canvas.drawCircle(center, 7, Paint()..color = const Color(0xFF212121));
    canvas.drawCircle(center, 4, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(ClockPainter old) => old.elapsed != elapsed;
}