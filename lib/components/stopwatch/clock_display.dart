import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
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
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 48),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: CustomPaint(painter: ClockPainter(elapsed)),
          ),
        ),
        const SizedBox(height: 20),
        // Time text — font diperkecil sedikit agar HH:MM:SS.ms tetap muat
        Text(
          formattedTime,
          style: const TextStyle(
            fontSize: 36,          // sebelumnya 48, dikecilkan agar format panjang muat
            fontWeight: FontWeight.w800,
            color: AppTheme.textPrimary,
            letterSpacing: -1.0,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}