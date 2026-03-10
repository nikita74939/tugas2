import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

// layar kalkulator
class CalculatorDisplay extends StatelessWidget {
  final String question;
  final String answer;
  final bool hasError;

  const CalculatorDisplay({
    super.key,
    required this.question,
    required this.answer,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 8),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // Question
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              question.isEmpty ? '0' : question,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.cardSubtitle.copyWith(
                fontSize: 16,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          
          // Answer
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              answer,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: !hasError ? 40 : 20,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.5,
                color: hasError ? Colors.red.shade400 : AppTheme.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
