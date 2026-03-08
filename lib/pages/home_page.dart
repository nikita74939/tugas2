import 'package:flutter/material.dart';
import 'package:tugas2/pages/calculator_page.dart';
import 'package:tugas2/pages/stopwatch_page.dart';
import 'package:tugas2/pages/number_checker_page.dart';
import 'package:tugas2/pages/pyramid_page.dart';
import 'package:tugas2/pages/field_counter_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _menus = [
    _MenuItem(icon: Icons.calculate_rounded,     label: 'Calculator',      subtitle: 'Operasi matematika dasar',    color: Color(0xFF4CAF50), page: CalculatorPage()),
    _MenuItem(icon: Icons.timer_rounded,          label: 'Stopwatch',       subtitle: 'Hitung waktu dengan lap',     color: Color(0xFF2196F3), page: StopwatchPage()),
    _MenuItem(icon: Icons.tag_rounded,            label: 'Number Checker',  subtitle: 'Cek ganjil, genap, prima',    color: Color(0xFF9C27B0), page: NumberCheckerPage()),
    _MenuItem(icon: Icons.change_history_rounded, label: 'Pyramid',         subtitle: 'Luas & volume limas',         color: Color(0xFFFF9800), page: PyramidPage()),
    _MenuItem(icon: Icons.list_alt_rounded,       label: 'Field Counter',   subtitle: 'Hitung total angka di field', color: Color(0xFFE91E63), page: FieldCounterPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        title: const Text(
          'Math Tools',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Tools',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: _menus.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) => _MenuCard(item: _menus[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final _MenuItem item;
  const _MenuCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => item.page)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, color: item.color, size: 26),
            ),
            const SizedBox(width: 16),
            // Label
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(item.subtitle, style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final Widget page;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.page,
  });
}