import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color primary = Colors.black;
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Color(0xFF9E9E9E);
  static const Color border = Color(0xFFE0E0E0);
  static const Color iconBg = Color(0xFFF0F0F0);

  // Text Styles
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
    letterSpacing: 1.2,
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

  // Decorations
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

  static BoxDecoration iconDecoration = BoxDecoration(
    color: iconBg,
    borderRadius: BorderRadius.circular(12),
  );
}