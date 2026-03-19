import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class HijriDisplayCard extends StatelessWidget {
  final String title;
  final String result;

  const HijriDisplayCard({
    super.key,
    required this.title,
    required this.result,
  });

  // Identifikasi apakah [result] mengandung pesan kesalahan
  bool get _hasError {
    final lowerResult = result.toLowerCase();
    return lowerResult.contains("error") ||
        lowerResult.contains("tidak") ||
        lowerResult.contains("harus");
  }

  @override
  Widget build(BuildContext context) {
    // Definisi warna
    final List<Color> carfGradient =
        _hasError
            ? [Colors.redAccent, Colors.red]
            : [AppTheme.primary, const Color(0xFF6A11CB)];
    final Color shadowColor =
        _hasError
            ? Colors.redAccent.withOpacity(0.3)
            : AppTheme.primary.withOpacity(0.3);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: carfGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            result.isEmpty ? "..." : result,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
