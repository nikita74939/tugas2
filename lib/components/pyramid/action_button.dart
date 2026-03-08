import 'package:flutter/material.dart';
import '../../models/pyramid_result.dart';
import '../../utils/app_theme.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final PyramidResult type;
  final PyramidResult activeResult;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.label,
    required this.type,
    required this.activeResult,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = activeResult == type;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primary : AppTheme.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isActive ? 0.18 : 0.05),
              blurRadius: isActive ? 8 : 4,
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
              color: isActive ? Colors.white : AppTheme.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}