import 'package:flutter/material.dart';
import '../../models/pyramid_result.dart';
import '../../utils/app_theme.dart';

// Widget kartu hasil kalkulasi limas — tampilan berbeda antara hasil normal dan error
class ResultCard extends StatelessWidget {
  final String result;          // Nilai hasil atau pesan error
  final String resultLabel;     // Label jenis hasil, misal: "Luas Permukaan" / "Volume"
  final bool isError;           // Jika true, kartu tampil abu dengan teks merah
  final PyramidResult activeResult; // Menentukan satuan: ² untuk luas, ³ untuk volume

  const ResultCard({
    super.key,
    required this.result,
    required this.resultLabel,
    required this.isError,
    required this.activeResult,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(

        // Normal: hitam — Error: abu muda
        color: isError ? const Color(0xFFF5F5F5) : AppTheme.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isError ? 0.05 : 0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // Expanded mencegah teks hasil overflow ke arah ikon di kanan
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Label kecil di atas hasil — "Error" atau nama jenis kalkulasi
                Text(
                  isError ? 'Error' : resultLabel.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: isError ? AppTheme.textSecondary : Colors.white60,
                  ),
                ),
                const SizedBox(height: 4),

                // Hasil: tambahkan satuan ² atau ³ tergantung jenis kalkulasi
                Text(
                  isError
                      ? result
                      : '$result satuan${activeResult == PyramidResult.volume ? '³' : '²'}',
                  style: TextStyle(
                    fontSize: isError ? 16 : 24, // Error lebih kecil karena teksnya panjang
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: isError ? Colors.red : Colors.white,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          
          // Ikon status: centang untuk hasil valid, tanda seru untuk error
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isError ? AppTheme.iconBg : Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isError ? Icons.error_outline_rounded : Icons.check_rounded,
              color: isError ? AppTheme.textSecondary : Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}