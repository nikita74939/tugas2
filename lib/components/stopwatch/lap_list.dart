import 'package:flutter/material.dart';
import '../../models/lap_data.dart';
import '../../utils/app_theme.dart';

class LapList extends StatelessWidget {
  final List<LapData> laps;
  final String Function(Duration) formatDuration;

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
        final isFirst = i == 0;

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
              // Badge
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
              // Split time
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
              // Total time
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