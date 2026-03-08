import 'package:flutter/material.dart';

class PyramidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final paint = Paint()..style = PaintingStyle.fill;

    // Shadow
    paint.color = Colors.grey.shade200;
    final shadowPath = Path()
      ..moveTo(cx - 90, 130)
      ..lineTo(cx + 90, 130)
      ..lineTo(cx + 60, 145)
      ..lineTo(cx - 60, 145)
      ..close();
    canvas.drawPath(shadowPath, paint);

    // Sisi kiri (terang)
    paint.color = Colors.green.shade300;
    final leftFace = Path()
      ..moveTo(cx, 20)
      ..lineTo(cx - 90, 130)
      ..lineTo(cx + 90, 130)
      ..close();
    canvas.drawPath(leftFace, paint);

    // Sisi kanan (gelap)
    paint.color = Colors.green.shade600;
    final rightFace = Path()
      ..moveTo(cx, 20)
      ..lineTo(cx + 90, 130)
      ..lineTo(cx + 50, 110)
      ..close();
    canvas.drawPath(rightFace, paint);

    // Outline
    final outlinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.green.shade700
      ..strokeWidth = 1.5;
    final outline = Path()
      ..moveTo(cx, 20)
      ..lineTo(cx - 90, 130)
      ..lineTo(cx + 90, 130)
      ..close();
    canvas.drawPath(outline, outlinePaint);

    // Garis tinggi (putus-putus)
    final dashedPaint = Paint()
      ..color = Colors.grey.shade500
      ..strokeWidth = 1;
    for (double y = 20; y < 130; y += 8) {
      canvas.drawLine(Offset(cx, y), Offset(cx, y + 4), dashedPaint);
    }

    // Label
    final textStyle = TextStyle(color: Colors.grey.shade600, fontSize: 12);
    void drawLabel(String text, Offset offset) {
      final tp = TextPainter(
        text: TextSpan(text: text, style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, offset);
    }

    drawLabel('t', Offset(cx + 4, 65));
    drawLabel('a', Offset(cx - 10, 135));
    drawLabel('s', Offset(cx + 48, 72));
  }

  @override
  bool shouldRepaint(_) => false;
}