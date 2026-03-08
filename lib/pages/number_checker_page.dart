import 'package:flutter/material.dart';
import '../controllers/number_checker_controller.dart';
import '../components/number checker/number_display.dart';
import '../components/number checker/number_keypad.dart';
import '../utils/app_theme.dart';

class NumberCheckerPage extends StatefulWidget {
  const NumberCheckerPage({super.key});

  @override
  State<NumberCheckerPage> createState() => _NumberCheckerPageState();
}

class _NumberCheckerPageState extends State<NumberCheckerPage> {
  final _ctrl = NumberCheckerController();

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Number Checker', style: AppTheme.titleLarge),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: NumberDisplay(
              input: _ctrl.input,
              result: _ctrl.result,
              resultColor: _ctrl.resultColor,
            ),
          ),
          Expanded(
            flex: 2,
            child: NumberKeypad(
              onTap: (label) => setState(() => _ctrl.onTap(label)),
            ),
          ),
        ],
      ),
    );
  }
}
