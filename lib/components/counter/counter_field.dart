import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

// Widget input satu baris data counter — mendukung banyak angka sekaligus
class CounterField extends StatelessWidget {
  final int index;                      // Posisi field (untuk tampilan nomor urut)
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool showRemove;                // Tombol hapus hanya muncul jika ada lebih dari satu field
  final VoidCallback onRemove;          // Dipanggil saat user menekan tombol hapus
  final VoidCallback onChanged;         // Dipanggil setiap kali isi field berubah
  final String? errorText;              // Jika tidak null, banner error ditampilkan di bawah field

  const CounterField({
    super.key,
    required this.index,
    required this.controller,
    required this.focusNode,
    required this.showRemove,
    required this.onRemove,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [

          // Field utama: nomor urut + input teks + tombol hapus
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // Badge nomor urut (index + 1 agar dimulai dari 1, bukan 0)
                Container(
                  width: 44,
                  padding: const EdgeInsets.only(top: 14),
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: AppTheme.iconBg,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                ),

                // Input multiline — user bisa ketik banyak angka dipisah spasi/koma
                Expanded(
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    keyboardType: TextInputType.multiline,
                    maxLines: null, // Tinggi field menyesuaikan isi teks
                    onChanged: (_) => onChanged(),
                    style: AppTheme.cardTitle.copyWith(fontSize: 14),
                    decoration: InputDecoration(
                      hintText:
                          'Masukkan angka (pisah spasi/koma)\nContoh: 10, 20, 30',
                      hintStyle: AppTheme.cardSubtitle,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 4,
                      ),
                    ),
                  ),
                ),

                // Tombol hapus — hanya tampil jika showRemove = true
                if (showRemove)
                  GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppTheme.iconBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: AppTheme.textSecondary,
                        size: 16,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Banner error — hanya muncul jika errorText tidak null
          if (errorText != null) ...[
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFF3B30),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_rounded, color: Colors.white, size: 15),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      errorText!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}