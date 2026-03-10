// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

// jenis tampilan tombol kalkulator
enum ButtonVariant { normal, operator, action, equals }

// widget tombol
class MyButton extends StatelessWidget {
  final String buttonText;
  final ButtonVariant variant; // warna & ukuran tombol
  final VoidCallback? buttonTapped; 

  const MyButton({
    super.key,
    required this.buttonText,
    this.variant = ButtonVariant.normal, // default: tombol angka biasa
    this.buttonTapped,
  });

  @override
  Widget build(BuildContext context) {
    final bg = _backgroundColor();
    final fg = _foregroundColor();

    return GestureDetector(
      onTap: buttonTapped,
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),

          // shadow lebih tebal untuk tombol "="
          boxShadow: variant == ButtonVariant.equals
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
        ),

        // text button
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: fg,
              fontSize: variant == ButtonVariant.equals ? 26 : 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ),
    );
  }

  // bg berdasarkan jenis tombol
  Color _backgroundColor() {
    switch (variant) {
      case ButtonVariant.equals:
        return AppTheme.primary;      
      case ButtonVariant.operator:
        return AppTheme.iconBg;        
      case ButtonVariant.action:
        return AppTheme.iconBg;        
      case ButtonVariant.normal:
        return AppTheme.surface;       
    }
  }

  // warna teks
  Color _foregroundColor() {
    switch (variant) {
      case ButtonVariant.equals:
        return Colors.white;
      case ButtonVariant.operator:
        return AppTheme.textPrimary;  
      case ButtonVariant.action:
        return AppTheme.textSecondary; 
      case ButtonVariant.normal:
        return AppTheme.textPrimary;
    }
  }
}