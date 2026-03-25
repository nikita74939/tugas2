import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class AgeResultCard extends StatelessWidget {
  final Map<String, int>? age;

  const AgeResultCard({super.key, this.age});

  @override
  Widget build(BuildContext context) {
    if (age == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: const Column(
          children: [
            Icon(Icons.cake_outlined, color: Colors.grey, size: 40),
            SizedBox(height: 12),
            Text(
              "Belum ada data.\nSilakan pilih tanggal lahirmu.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primary, Color(0xFF6A11CB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "UMUR KAMU SAAT INI",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Bagian Tahun, Bulan, Hari
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimeInfo("${age!['years']}", "Tahun"),
              _buildDivider(),
              _buildTimeInfo("${age!['months']}", "Bulan"),
              _buildDivider(),
              _buildTimeInfo("${age!['days']}", "Hari"),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Divider(color: Colors.white24, thickness: 1),
          ),

          // Bagian Jam, Menit, dan Detik (UPDATE DI SINI)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.access_time, color: Colors.white70, size: 18),
              const SizedBox(width: 8),
              Text(
                "${age!['hours']}j  :  ${age!['minutes']}m  :  ${age!['seconds']}d",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily:
                      'monospace', // Biar angka nggak goyang saat detik ganti
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget bantuan untuk menampilkan angka dan label (Tahun/Bulan/Hari)
  Widget _buildTimeInfo(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  // Garis pemisah vertikal antar angka
  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.white24,
    );
  }
}
