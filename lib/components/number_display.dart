import 'package:flutter/material.dart';

class NumberDisplay extends StatelessWidget {
  final String input;
  final String result;
  final Color resultColor;

  const NumberDisplay({
    super.key,
    required this.input,
    required this.result,
    required this.resultColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            input.isEmpty ? '0' : input,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w300,
              color: Colors.black87,
            ),
          ),
          Text(
            result,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: result.isEmpty ? Colors.transparent : resultColor,
            ),
          ),
        ],
      ),
    );
  }
}
