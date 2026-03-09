import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class SummaryCard extends StatelessWidget {
  final List<double> numbers;
  final String Function(double) fmt;

  const SummaryCard({super.key, required this.numbers, required this.fmt});

  @override
  Widget build(BuildContext context) {
    final count = numbers.length;
    final sum = numbers.fold(0.0, (a, b) => a + b);
    final avg = count > 0 ? sum / count : 0.0;
    final min = count > 0 ? numbers.reduce((a, b) => a < b ? a : b) : 0.0;
    final max = count > 0 ? numbers.reduce((a, b) => a > b ? a : b) : 0.0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TOTAL ANGKA', style: AppTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(
                      '$count',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textPrimary,
                        letterSpacing: -1.5,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.numbers_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ],
            ),
            if (count > 0) ...[
              const SizedBox(height: 16),
              Container(height: 1, color: AppTheme.border),
              const SizedBox(height: 14),
              Row(
                children: [
                  _statChip('Jumlah', fmt(sum)),
                  _divider(),
                  _statChip('Rata-rata', fmt(avg)),
                  _divider(),
                  _statChip('Min', fmt(min)),
                  _divider(),
                  _statChip('Maks', fmt(max)),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _divider() => Container(
    // margin: EdgeInsets.symmetric(horizontal: 4),
    width: 1,
    height: 32,
    color: AppTheme.border,
  );

  Widget _statChip(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: AppTheme.cardSubtitle),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(value, style: AppTheme.cardTitle),
          ),
        ],
      ),
    );
  }
}
