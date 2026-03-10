import 'package:flutter/material.dart';

// Pusat definisi tema aplikasi — semua warna, teks, dan dekorasi ada di sini
// Gunakan nilai dari class ini agar tampilan konsisten di seluruh app
class AppTheme {
  // Warna utama
  static const Color background = Color(0xFFF5F5F5); // Abu sangat muda — latar halaman
  static const Color surface = Colors.white;           // Putih — latar kartu & field
  static const Color primary = Colors.black;           // Hitam — tombol utama & aksen
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Color(0xFF9E9E9E); // Abu — teks placeholder & label
  static const Color border = Color(0xFFE0E0E0);        // Abu muda — garis pembatas
  static const Color iconBg = Color(0xFFF0F0F0);        // Abu — background ikon & badge

  // Gaya teks — gunakan .copyWith() jika perlu variasi kecil
  static const TextStyle titleLarge = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: textSecondary,
    letterSpacing: 1.2, // Spasi lebar untuk label uppercase
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    letterSpacing: -0.2,
  );

  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textSecondary,
  );

  // Dekorasi kartu standar — tidak const karena withOpacity tidak bisa const
  static BoxDecoration cardDecoration = BoxDecoration(
    color: surface,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // Dekorasi background ikon — tanpa shadow, lebih ringan dari cardDecoration
  static BoxDecoration iconDecoration = BoxDecoration(
    color: iconBg,
    borderRadius: BorderRadius.circular(12),
  );
}