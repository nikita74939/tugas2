import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/calculator_controller.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        title: const Text(
          'Calculator',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
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
          const Expanded(
            flex: 2,
            child: CalculatorKeypad(),
          ),
        ],
      ),
    );
  }
}