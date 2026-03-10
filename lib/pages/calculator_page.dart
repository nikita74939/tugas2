import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/calculator_controller.dart';
import '../../utils/app_theme.dart';
import '../components/calculator/calculator_display.dart';
import '../components/calculator/calculator_keypad.dart';

// Halaman kalkulator — membungkus view dengan ChangeNotifierProvider
class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider dibuat di sini agar CalculatorController hanya hidup selama halaman ini aktif
    return ChangeNotifierProvider(
      create: (_) => CalculatorController(),
      child: const _CalculatorView(),
    );
  }
}

// View terpisah dari provider agar context.watch bisa mengakses controller di atasnya
class _CalculatorView extends StatelessWidget {
  const _CalculatorView();

  @override
  Widget build(BuildContext context) {
    // watch() — view rebuild otomatis setiap kali controller memanggil notifyListeners()
    final ctrl = context.watch<CalculatorController>();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        // Tombol back custom agar tampilan konsisten dengan desain app
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
          // Display (flex 1) lebih kecil dari keypad (flex 2) — prioritas area input
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