import 'package:flutter/material.dart';

class NumberCheckerController {
  String input = '';
  String result = '';

  void onTap(String label) {
    switch (label) {
      case 'DEL':
        if (input.isNotEmpty) input = input.substring(0, input.length - 1);
        result = '';
      case 'CHECK':
        result = input.isEmpty ? 'Masukkan angka dulu' : _check(int.tryParse(input));
      default:
        if (input.length < 10) input += label;
    }
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

  Color get resultColor {
    if (result.contains('Prima')) return Colors.purple;
    if (result.contains('Genap')) return Colors.blue;
    if (result.contains('Ganjil')) return Colors.orange;
    return Colors.red;
  }
}