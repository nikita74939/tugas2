import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

enum ButtonVariant { normal, operator, action, equals }

class MyButton extends StatelessWidget {
  final String buttonText;
  final ButtonVariant variant;
  final VoidCallback? buttonTapped;

  const MyButton({
    super.key,
    required this.buttonText,
    this.variant = ButtonVariant.normal,
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

  Color _backgroundColor() {
    switch (variant) {
      case ButtonVariant.equals:
        return AppTheme.primary;       // black
      case ButtonVariant.operator:
        return AppTheme.iconBg;        // light grey
      case ButtonVariant.action:
        return AppTheme.iconBg;        // light grey
      case ButtonVariant.normal:
        return AppTheme.surface;       // white
    }
  }

  Color _foregroundColor() {
    switch (variant) {
      case ButtonVariant.equals:
        return Colors.white;
      case ButtonVariant.operator:
        return AppTheme.textPrimary;   // black text on grey
      case ButtonVariant.action:
        return AppTheme.textSecondary; // grey text (DEL etc)
      case ButtonVariant.normal:
        return AppTheme.textPrimary;
    }
  }
}