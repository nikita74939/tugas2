import 'package:flutter/material.dart';
import '../../models/pyramid_result.dart';
import '../../utils/app_theme.dart';

// Tombol aksi dengan tiga state: disabled, aktif (terpilih), dan normal
class ActionButton extends StatelessWidget {
  final String label;
  final PyramidResult type;         // Jenis hasil yang diwakili tombol ini
  final PyramidResult activeResult; // Hasil yang sedang aktif/terpilih saat ini
  final VoidCallback onTap;
  final bool enabled;               // Jika false, tombol tidak bisa ditekan dan tampil abu

  const ActionButton({
    super.key,
    required this.label,
    required this.type,
    required this.activeResult,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    // Tombol dianggap aktif jika type-nya sama dengan hasil yang sedang dipilih
    final isActive = activeResult == type;

    // Prioritas warna: disabled → aktif → normal
    Color bgColor;
    Color textColor;
    if (!enabled) {
      bgColor = AppTheme.iconBg;           // Abu — tombol tidak tersedia
      textColor = const Color(0xFFBDBDBD);
    } else if (isActive) {
      bgColor = AppTheme.primary;          // Hitam — tombol terpilih
      textColor = Colors.white;
    } else {
      bgColor = AppTheme.surface;          // Putih — tombol tersedia tapi tidak terpilih
      textColor = AppTheme.textPrimary;
    }

    return GestureDetector(
      onTap: enabled ? onTap : null, // Nonaktifkan gesture jika disabled
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          // Shadow lebih tebal saat tombol aktif agar terlihat menonjol
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isActive && enabled ? 0.18 : 0.05),
              blurRadius: isActive && enabled ? 8 : 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}