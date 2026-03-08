import 'package:flutter/material.dart';
import '../models/pyramid_result.dart';

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          color: isActive ? Colors.green : Colors.white,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : Colors.green,
              ),
            ),
          ),
        ),
      ),
    );
  }
}