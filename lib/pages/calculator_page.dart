import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/calculator_controller.dart';
import '../../utils/app_theme.dart';
import '../components/calculator/calculator_display.dart';
import '../components/calculator/calculator_keypad.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalculatorController(),
      child: const _CalculatorView(),
    );
  }
}

class _CalculatorView extends StatelessWidget {
  const _CalculatorView();

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<CalculatorController>();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: AppTheme.primary,
              size: 20,
            ),
          ),
        ),
        title: const Text('Calculator', style: AppTheme.titleLarge),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: CalculatorDisplay(
              question: ctrl.userQuestion,
              answer: ctrl.userAnswer,
              hasError: ctrl.hasError,
            ),
          ),
          const Expanded(flex: 2, child: CalculatorKeypad()),
        ],
      ),
    );
  }
}
