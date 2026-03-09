import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class NumberDisplay extends StatelessWidget {
  final String input;
  final String result;
  final Color resultColor;

  const NumberDisplay({
    super.key,
    required this.input,
    required this.result,
    required this.resultColor,
  });

  @override
  Widget build(BuildContext context) {
    // Map warna asli (hijau/merah) ke B&W: hasil valid → hitam, error → abu gelap
    final bool hasResult = result.isNotEmpty;

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
          // Result label
          Container(
            padding:
                hasResult
                    ? const EdgeInsets.symmetric(horizontal: 20, vertical: 6)
                    : EdgeInsets.zero,
            decoration:
                hasResult
                    ? BoxDecoration(
                      color: AppTheme.iconBg,
                      borderRadius: BorderRadius.circular(20),
                    )
                    : null,
            child: Text(
              result,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
                color: hasResult ? AppTheme.textPrimary : Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
