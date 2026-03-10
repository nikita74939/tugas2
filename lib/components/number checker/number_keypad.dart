import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

// Widget keypad angka — dipakai untuk input numerik dengan tombol DEL dan CHECK
class NumberKeypad extends StatelessWidget {
  final void Function(String) onTap; // Callback dengan label tombol yang ditekan

  const NumberKeypad({super.key, required this.onTap});

  // Layout tombol keypad — dipisah jadi konstanta agar mudah diubah tanpa menyentuh logika
  static const _buttons = [
    ['7', '8', '9'],
    ['4', '5', '6'],
    ['1', '2', '3'],
    ['DEL', '0', 'CHECK'],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: _buttons.map((row) {
          return Expanded(
            child: Row(
              children: row.map((label) => _buildKey(label)).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildKey(String label) {
    final isCheck = label == 'CHECK'; // Tombol konfirmasi — tampil hitam & menonjol
    final isDel = label == 'DEL';     // Tombol hapus — tampil sebagai ikon, bukan teks

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(label),
        child: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: isCheck ? AppTheme.primary : AppTheme.surface,
            borderRadius: BorderRadius.circular(14),
            // Shadow lebih tebal pada CHECK agar terlihat lebih penting
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isCheck ? 0.18 : 0.05),
                blurRadius: isCheck ? 8 : 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            // DEL tampil sebagai ikon backspace, tombol lain tampil sebagai teks
            child: isDel
                ? const Icon(
                    Icons.backspace_outlined,
                    color: AppTheme.textSecondary,
                    size: 22,
                  )
                : Text(
                    label,
                    style: TextStyle(
                      fontSize: isCheck ? 15 : 22, // CHECK lebih kecil karena labelnya panjang
                      fontWeight: FontWeight.w700,
                      letterSpacing: isCheck ? 0.5 : -0.5,
                      color: isCheck ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}