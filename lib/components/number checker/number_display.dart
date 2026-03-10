import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

// Widget layar input angka — menampilkan angka yang diketik dan hasil konversi/operasi
class NumberDisplay extends StatelessWidget {
  final String input;        // Angka yang sedang diketik user
  final String result;       // Hasil operasi (kosong jika belum ada hasil)
  final Color resultColor;   // Warna teks hasil (bisa merah/hijau tergantung konteks)

  const NumberDisplay({
    super.key,
    required this.input,
    required this.result,
    required this.resultColor,
  });

  @override
  Widget build(BuildContext context) {
    // Flag untuk mengontrol tampilan badge hasil — jika kosong, badge disembunyikan
    final bool hasResult = result.isNotEmpty;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          
          // Angka input ditampilkan besar — fallback ke "0" jika belum ada input
          Text(
            input.isEmpty ? '0' : input,
            style: const TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
              letterSpacing: -2,
              height: 1,
            ),
          ),

          // Badge hasil — padding & background hanya muncul jika hasResult = true
          // Jika belum ada hasil, teks dibuat transparan agar layout tidak bergeser
          Container(
            padding: hasResult
                ? const EdgeInsets.symmetric(horizontal: 18, vertical: 6)
                : EdgeInsets.zero,
            decoration: hasResult
                ? BoxDecoration(
                    color: AppTheme.iconBg,
                    borderRadius: BorderRadius.circular(20),
                  )
                : null,
            child: Text(
              result,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
                color: hasResult ? AppTheme.textPrimary : Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}