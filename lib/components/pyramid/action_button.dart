import 'package:flutter/material.dart';
import '../../models/pyramid_result.dart';
import '../../utils/app_theme.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final PyramidResult type;
  final PyramidResult activeResult;
  final VoidCallback onTap;
  final bool enabled;

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
    final isActive = activeResult == type;

    Color bgColor;
    Color textColor;
    if (!enabled) {
      bgColor = AppTheme.iconBg;
      textColor = const Color(0xFFBDBDBD);
    } else if (isActive) {
      bgColor = AppTheme.primary;
      textColor = Colors.white;
    } else {
      bgColor = AppTheme.surface;
      textColor = AppTheme.textPrimary;
    }

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
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