import 'package:flutter/material.dart';
import '../../models/pyramid_result.dart';
import '../../utils/app_theme.dart';

class ResultCard extends StatelessWidget {
  final String result;
  final String resultLabel;
  final bool isError;
  final PyramidResult activeResult;

  const ResultCard({
    super.key,
    required this.result,
    required this.resultLabel,
    required this.isError,
    required this.activeResult,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: isError ? const Color(0xFFF5F5F5) : AppTheme.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isError ? 0.05 : 0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isError ? 'Error' : resultLabel.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  color: isError ? AppTheme.textSecondary : Colors.white60,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isError ? result : '$result satuan${activeResult == PyramidResult.volume ? '³' : '²'}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: isError ? AppTheme.textPrimary : Colors.white,
                ),
              ),
            ],
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isError ? AppTheme.iconBg : Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isError ? Icons.error_outline_rounded : Icons.check_rounded,
              color: isError ? AppTheme.textSecondary : Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}