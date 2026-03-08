import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Angka', style: TextStyle(fontSize: 14, color: Colors.black54)),
                Text(
                  '$count',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green.shade600),
                ),
              ],
            ),
            if (count > 0) ...[
              const Divider(height: 16),
              Row(
                children: [
                  _statChip('Jumlah', fmt(sum)),
                  _statChip('Rata-rata', fmt(avg)),
                  _statChip('Min', fmt(min)),
                  _statChip('Maks', fmt(max)),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _statChip(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}