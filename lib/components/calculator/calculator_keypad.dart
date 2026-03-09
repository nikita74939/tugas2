import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calculator_button.dart';
import '../../controllers/calculator_controller.dart';
import '../../utils/calculator_util.dart';

class CalculatorKeypad extends StatelessWidget {
  const CalculatorKeypad({super.key});

  // Map label → variant
  ButtonVariant _variantFor(String label) {
    if (label == '=') return ButtonVariant.equals;
    if (label == 'DEL' || label == 'AC') return ButtonVariant.action;
    if (operators.contains(label)) return ButtonVariant.operator;
    return ButtonVariant.normal;
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = context.read<CalculatorController>();

    return Container(
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
           
          Expanded(
            flex: 3,
            child: Column(
              children: leftButtons
                  .map((row) => _buildRow(context, row))
                  .toList(),
            ),
          ),
           
          Expanded(
            flex: 1,
            child: Column(
              children: [
                ...['DEL', '-', '+'].map((l) => _buildSingle(context, l)),
                Expanded(
                  flex: 2,
                  child: MyButton(
                    buttonText: '=',
                    variant: ButtonVariant.equals,
                    buttonTapped: () => ctrl.onButtonTapped('='),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, List<String> labels) {
    final ctrl = context.read<CalculatorController>();
    return Expanded(
      child: Row(
        children: labels.map((label) {
          return Expanded(
            child: MyButton(
              buttonText: label,
              variant: _variantFor(label),
              buttonTapped: () => ctrl.onButtonTapped(label),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSingle(BuildContext context, String label) {
    final ctrl = context.read<CalculatorController>();
    return Expanded(
      child: MyButton(
        buttonText: label,
        variant: _variantFor(label),
        buttonTapped: () => ctrl.onButtonTapped(label),
      ),
    );
  }
}