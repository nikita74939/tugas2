import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          // Question — scroll horizontal kalau panjang
          Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true, // scroll otomatis ke kanan (karakter terbaru)
              child: Text(
                question.isEmpty ? '0' : question,
                style: AppTheme.cardSubtitle.copyWith(
                  fontSize: 18,
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Answer — font auto-shrink kalau panjang
          Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: !hasError ? 40 : 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.5,
                  color: hasError ? Colors.red.shade400 : AppTheme.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}