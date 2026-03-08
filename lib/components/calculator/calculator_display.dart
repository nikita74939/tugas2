import 'package:flutter/material.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 50),
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          child: Text(question, style: const TextStyle(fontSize: 18)),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            answer,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: hasError ? Colors.red : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}