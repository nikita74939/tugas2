import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class SummaryCard extends StatelessWidget {
  final int totalCount; // Ini isi dari totalSmartCounter
  final int
  totalNumbers; // Ini isi dari totalNumberGroups (Angka 123 dihitung 1)
  final int totalWords; // Total kata

  const SummaryCard({
    super.key,
    required this.totalCount,
    required this.totalNumbers,
    required this.totalWords,
  });

  @override
  Widget build(BuildContext context) {
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
            // Header: Total Hitungan (Smart)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TOTAL HITUNGAN', style: AppTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(
                      '$totalCount',
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
                    Icons.calculate_rounded, // Ikon ganti jadi kalkulator
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            Container(height: 1, color: AppTheme.border),
            const SizedBox(height: 14),

            // Statistik bawah yang baru
            Row(
              children: [
                _statChip('Data Angka', '$totalNumbers'),
                _divider(),
                _statChip('Total Kata', '$totalWords'),
                _divider(),
                _statChip('Karakter Lain', '${totalCount - totalNumbers}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Container(width: 1, height: 32, color: AppTheme.border);

  Widget _statChip(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: AppTheme.cardSubtitle),
          const SizedBox(height: 4),
          Text(value, style: AppTheme.cardTitle.copyWith(fontSize: 14)),
        ],
      ),
    );
  }
}
