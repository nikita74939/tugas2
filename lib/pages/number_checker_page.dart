import 'package:flutter/material.dart';

class NumberCheckerPage extends StatefulWidget {
  const NumberCheckerPage({super.key});

  @override
  State<NumberCheckerPage> createState() => _NumberCheckerPageState();
}

class _NumberCheckerPageState extends State<NumberCheckerPage> {
  String _input = '';
  String _result = '';

  static const _buttons = [
    ['7', '8', '9'],
    ['4', '5', '6'],
    ['1', '2', '3'],
    ['DEL', '0', 'CHECK'],
  ];

  void _onTap(String label) {
    setState(() {
      switch (label) {
        case 'DEL':
          if (_input.isNotEmpty) _input = _input.substring(0, _input.length - 1);
          _result = '';
        case 'CHECK':
          _result = _input.isEmpty ? 'Masukkan angka dulu' : _check(int.tryParse(_input));
        default:
          if (_input.length < 10) _input += label;
      }
    });
  }

  String _check(int? number) {
    if (number == null) return 'Input tidak valid';
    if (number < 0) return 'Masukkan bilangan positif';
    if (_isPrime(number)) return '$number adalah Bilangan Prima';
    if (number % 2 == 0) return '$number adalah Bilangan Genap';
    return '$number adalah Bilangan Ganjil';
  }

  bool _isPrime(int n) {
    if (n < 2) return false;
    for (int i = 2; i <= n ~/ 2; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  Color get _resultColor {
    if (_result.contains('Prima')) return Colors.purple;
    if (_result.contains('Genap')) return Colors.blue;
    if (_result.contains('Ganjil')) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        title: const Text(
          'Number Checker',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Column(
        children: [
          // Display
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _input.isEmpty ? '0' : _input,
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w300, color: Colors.black87),
                  ),
                  Text(
                    _result,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: _result.isEmpty ? Colors.transparent : _resultColor),
                  ),
                ],
              ),
            ),
          ),
          // Keypad
          Expanded(
            flex: 2,
            child: Column(
              children: _buttons.map((row) {
                return Expanded(
                  child: Row(
                    children: row.map((label) {
                      final isCheck = label == 'CHECK';
                      final isDel = label == 'DEL';
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () => _onTap(label),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: isCheck ? Colors.green : Colors.white,
                                child: Center(
                                  child: isDel
                                      ? Icon(Icons.backspace_outlined, color: Colors.green, size: 22)
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
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}