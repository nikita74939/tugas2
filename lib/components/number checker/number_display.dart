import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class NumberDisplay extends StatelessWidget {
  final String input;
  final String resultParityLabel;
  final String resultPrimeLabel;
  final String errorMessage;
  final Color parityColor;
  final Color primeColor;

  const NumberDisplay({
    super.key,
    required this.input,
    required this.resultParityLabel,
    required this.resultPrimeLabel,
    required this.errorMessage,
    required this.parityColor,
    required this.primeColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasResult = resultParityLabel.isNotEmpty;
    final bool hasError  = errorMessage.isNotEmpty;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Input number — large
          Text(
            input.isEmpty ? '0' : input,
            style: const TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
              letterSpacing: -2,
              height: 1,
            ),
          ),

          // Result area
          if (hasError)
            _ResultChip(label: errorMessage, color: Colors.red)
          else if (hasResult)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _ResultChip(label: resultParityLabel, color: parityColor),
                const SizedBox(width: 8),
                _ResultChip(label: resultPrimeLabel,  color: primeColor),
              ],
            ),
        ],
      ),
    );
  }
}

class _ResultChip extends StatelessWidget {
  final String label;
  final Color color;

  const _ResultChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.35), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}