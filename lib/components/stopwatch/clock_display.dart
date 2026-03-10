import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import 'clock_painter.dart';

// Widget tampilan jam stopwatch — jarum analog di atas, teks digital di bawah
class ClockDisplay extends StatelessWidget {
  final Duration elapsed;      // Waktu berjalan, diteruskan ke ClockPainter untuk gambar jarum
  final String formattedTime;  // Teks waktu siap tampil, misal: "01:23.45"

  const ClockDisplay({
    super.key,
    required this.elapsed,
    required this.formattedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // Jam analog — lingkaran putih dengan jarum yang digambar via CustomPaint
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
            aspectRatio: 1, // Pastikan area gambar selalu berbentuk lingkaran sempurna
            child: CustomPaint(painter: ClockPainter(elapsed)),
          ),
        ),
        const SizedBox(height: 20),
        
        // Waktu digital — tabularFigures mencegah angka bergeser saat digit berubah
        Text(
          formattedTime,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w800,
            color: AppTheme.textPrimary,
            letterSpacing: -1.5,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}