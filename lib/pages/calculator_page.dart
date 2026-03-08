import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/calculator_button.dart';
import '../controllers/calculator_controller.dart';
import '../utils/calculator_util.dart';

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
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 50),
                _display(ctrl.userQuestion, Alignment.centerLeft, false),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    ctrl.userAnswer,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ctrl.hasError ? Colors.red : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children:
                        leftButtons
                            .map((row) => _buildButtonRow(context, row))
                            .toList(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      ...[
                        'DEL',
                        '-',
                        '+',
                      ].map((l) => _buildSingleButton(context, l)),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: MyButton(
                            buttonText: '=',
                            color: Colors.green,
                            textColor: Colors.white,
                            buttonTapped: () => ctrl.onButtonTapped('='),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _display(String text, Alignment align, bool bold) => Container(
    padding: const EdgeInsets.all(20),
    alignment: align,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );

  Widget _buildButtonRow(BuildContext context, List<String> labels) {
    final ctrl = context.read<CalculatorController>();
    return Expanded(
      child: Row(
        children:
            labels
                .map(
                  (label) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: MyButton(
                        buttonText: label,
                        color: Colors.white,
                        textColor:
                            operators.contains(label)
                                ? Colors.green
                                : Colors.black,
                        buttonTapped: () => ctrl.onButtonTapped(label),
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildSingleButton(BuildContext context, String label) {
    final ctrl = context.read<CalculatorController>();
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: MyButton(
          buttonText: label,
          color: Colors.white,
          textColor: Colors.green,
          buttonTapped: () => ctrl.onButtonTapped(label),
        ),
      ),
    );
  }
}
