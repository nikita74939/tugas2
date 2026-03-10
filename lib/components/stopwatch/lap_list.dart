import 'package:flutter/material.dart';
import '../../models/lap_data.dart';
import '../../utils/app_theme.dart';

// Widget daftar lap stopwatch — lap terbaru selalu di atas dengan tampilan menonjol
class LapList extends StatelessWidget {
  final List<LapData> laps;
  final String Function(Duration) formatDuration; // Fungsi format durasi dari parent

  const LapList({
    super.key,
    required this.laps,
    required this.formatDuration,
  });

  @override
  Widget build(BuildContext context) {
    if (laps.isEmpty) {
      return Center(
        child: Text('Belum ada lap', style: AppTheme.cardSubtitle),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: laps.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final lap = laps[i];
        final isFirst = i == 0; // Index 0 = lap terbaru — tampil hitam & menonjol

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isFirst ? AppTheme.primary : AppTheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isFirst ? 0.12 : 0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Badge nomor lap
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isFirst
                      ? Colors.white.withOpacity(0.15)
                      : AppTheme.iconBg,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${lap.index}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: isFirst ? Colors.white : AppTheme.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Split: waktu lap ini saja (selisih antar lap)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Split',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.8,
                      color: isFirst ? Colors.white60 : AppTheme.textSecondary,
                    ),
                  ),
                  Text(
                    formatDuration(lap.split),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isFirst ? Colors.white70 : AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Total: waktu kumulatif dari awal hingga lap ini
              Text(
                formatDuration(lap.total),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: isFirst ? Colors.white : AppTheme.textPrimary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}