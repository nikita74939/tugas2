import 'package:flutter/material.dart';
import 'clock_painter.dart';

class ClockDisplay extends StatelessWidget {
  final Duration elapsed;
  final String formattedTime;

  const ClockDisplay({
    super.key,
    required this.elapsed,
    required this.formattedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: AspectRatio(
            aspectRatio: 1,
            child: CustomPaint(painter: ClockPainter(elapsed)),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          formattedTime,
          style: TextStyle(
            fontSize: 52,
            fontWeight: FontWeight.w300,
            color: Colors.green.shade500,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}