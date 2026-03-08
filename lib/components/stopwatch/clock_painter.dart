import 'package:flutter/material.dart';
import 'dart:math';

class ClockPainter extends CustomPainter {
  final Duration elapsed;
  ClockPainter(this.elapsed);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background circle
    canvas.drawCircle(center, radius, Paint()..color = Colors.white);

    // Tick marks
    final tickPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1;
    for (int i = 0; i < 60; i++) {
      final angle = (i * 6) * pi / 180;
      final isMain = i % 5 == 0;
      final outer = center + Offset(cos(angle - pi / 2), sin(angle - pi / 2)) * radius * 0.95;
      final inner = center + Offset(cos(angle - pi / 2), sin(angle - pi / 2)) * radius * (isMain ? 0.85 : 0.90);
      canvas.drawLine(inner, outer, tickPaint..strokeWidth = isMain ? 1.5 : 0.8);
    }

    // Second hand
    final seconds = elapsed.inMilliseconds / 1000.0;
    final secAngle = (seconds * 6) * pi / 180;
    final handPaint = Paint()
      ..color = Colors.grey.shade700
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center - Offset(cos(secAngle - pi / 2), sin(secAngle - pi / 2)) * radius * 0.2,
      center + Offset(cos(secAngle - pi / 2), sin(secAngle - pi / 2)) * radius * 0.75,
      handPaint,
    );

    // Center dot
    canvas.drawCircle(center, 5, Paint()..color = Colors.white);
    canvas.drawCircle(
      center,
      5,
      Paint()
        ..color = Colors.grey.shade600
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(ClockPainter old) => old.elapsed != elapsed;
}