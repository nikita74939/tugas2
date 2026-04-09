import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class CounterField extends StatelessWidget {
  final int index;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool showRemove;
  final VoidCallback onRemove;
  final VoidCallback onChanged;
  final String? errorText;

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
    // Hitung statistik lokal untuk ditampilkan di bawah field
    final charCount = controller.text.length;
    final wordCount =
        controller.text.trim().isEmpty
            ? 0
            : controller.text.trim().split(RegExp(r'\s+')).length;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ), // Jarak antar field lebih lebar
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                // Nomor Urut
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

                // Input Berita
                Expanded(
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    keyboardType: TextInputType.multiline,
                    maxLines: null, // Membuat field bisa memanjang sesuai teks
                    minLines: 3, // Tinggi minimal agar enak buat paste berita
                    onChanged: (_) => onChanged(),
                    style: AppTheme.cardTitle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Masukkan data...',
                      hintStyle: AppTheme.cardSubtitle.copyWith(fontSize: 13),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 4,
                      ),
                    ),
                  ),
                ),

                // Tombol Hapus
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

          // Label Statistik & Error
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4, right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Info Karakter & Kata (Real-time)
                Text(
                  "$charCount Karakter | $wordCount Kata",
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // Error Message (jika ada)
                if (errorText != null)
                  Text(
                    errorText!,
                    style: const TextStyle(
                      color: Color(0xFFFF3B30),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
