import 'package:flutter/material.dart';

class NumberCheckerController {
  String input = '';
  String resultParityLabel = '';   // 'Genap' | 'Ganjil' | ''
  String resultPrimeLabel = '';    // 'Prima' | 'Bukan Prima' | ''
  String errorMessage = '';

  bool get hasResult => resultParityLabel.isNotEmpty;
  bool get hasError => errorMessage.isNotEmpty;

  void onTap(String label) {
    switch (label) {
      case 'DEL':
        if (input.isNotEmpty) input = input.substring(0, input.length - 1);
        _clearResult();
      case 'CHECK':
        _clearResult();
        if (input.isEmpty) {
          errorMessage = 'Masukkan angka dulu';
        } else {
          _check(int.tryParse(input));
        }
      default:
        if (input.length < 10) input += label;
        _clearResult();
    }
  }

  void _clearResult() {
    resultParityLabel = '';
    resultPrimeLabel = '';
    errorMessage = '';
  }

  void _check(int? number) {
    if (number == null) { errorMessage = 'Input tidak valid'; return; }
    if (number < 0)     { errorMessage = 'Masukkan bilangan positif'; return; }

    resultParityLabel = (number % 2 == 0) ? 'Genap' : 'Ganjil';
    resultPrimeLabel  = _isPrime(number)  ? 'Prima' : 'Bukan Prima';
  }

  bool _isPrime(int n) {
    if (n < 2) return false;
    for (int i = 2; i <= n ~/ 2; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  Color get parityColor => resultParityLabel == 'Genap' ? Colors.blue : Colors.orange;
  Color get primeColor  => resultPrimeLabel  == 'Prima' ? Colors.purple : Colors.grey;
}