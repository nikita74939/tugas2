import 'package:flutter/material.dart';
import '../models/pyramid_result.dart';

class ResultCard extends StatelessWidget {
  final String result;
  final String resultLabel;
  final bool isError;
  final PyramidResult activeResult;

  const ResultCard({
    super.key,
    required this.result,
    required this.resultLabel,
    required this.isError,
    required this.activeResult,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        color: isError ? Colors.red.shade50 : Colors.green.shade50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isError ? 'Error' : resultLabel,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isError ? Colors.red : Colors.green.shade700,
              ),
            ),
            Text(
              isError
                  ? result
                  : '$result satuan${activeResult == PyramidResult.volume ? '³' : '²'}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isError ? Colors.red : Colors.green.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}