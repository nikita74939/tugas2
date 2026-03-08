import 'package:flutter/material.dart';

class NumberKeypad extends StatelessWidget {
  final void Function(String) onTap;

  const NumberKeypad({super.key, required this.onTap});

  static const _buttons = [
    ['7', '8', '9'],
    ['4', '5', '6'],
    ['1', '2', '3'],
    ['DEL', '0', 'CHECK'],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buttons.map((row) {
        return Expanded(
          child: Row(
            children: row.map((label) => _buildKey(label)).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildKey(String label) {
    final isCheck = label == 'CHECK';
    final isDel = label == 'DEL';
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
          onTap: () => onTap(label),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: isCheck ? Colors.green : Colors.white,
              child: Center(
                child: isDel
                    ? const Icon(Icons.backspace_outlined, color: Colors.green, size: 22)
                    : Text(
                        label,
                        style: TextStyle(
                          fontSize: isCheck ? 16 : 20,
                          fontWeight: isCheck ? FontWeight.w600 : FontWeight.normal,
                          color: isCheck ? Colors.white : Colors.black87,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}