import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calculator_button.dart';
import '../../controllers/calculator_controller.dart';
import '../../utils/calculator_util.dart';

class CalculatorKeypad extends StatelessWidget {
  const CalculatorKeypad({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = context.read<CalculatorController>();

    return Row(
      children: [
        // Kolom kiri: grid angka & operator
        Expanded(
          flex: 3,
          child: Column(
            children: leftButtons
                .map((row) => _buildButtonRow(context, row))
                .toList(),
          ),
        ),
        // Kolom kanan: DEL, -, +, =
        Expanded(
          flex: 1,
          child: Column(
            children: [
              ...['DEL', '-', '+'].map((l) => _buildSingleButton(context, l)),
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
    );
  }

  Widget _buildButtonRow(BuildContext context, List<String> labels) {
    final ctrl = context.read<CalculatorController>();
    return Expanded(
      child: Row(
        children: labels.map((label) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: MyButton(
                buttonText: label,
                color: Colors.white,
                textColor: operators.contains(label) ? Colors.green : Colors.black,
                buttonTapped: () => ctrl.onButtonTapped(label),
              ),
            ),
          );
        }).toList(),
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