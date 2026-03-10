import 'package:flutter/material.dart';

// Controller untuk fitur Number Checker — mengelola input dan logika pengecekan bilangan
class NumberCheckerController {
  String input = '';  // Angka yang sedang diketik user (maksimal 10 digit)
  String result = ''; // Hasil pengecekan atau pesan error

  // Titik masuk semua aksi keypad — DEL, CHECK, dan input angka
  void onTap(String label) {
    switch (label) {
      case 'DEL':
        if (input.isNotEmpty) input = input.substring(0, input.length - 1);
        result = ''; // Hapus hasil saat input berubah
      case 'CHECK':
        result = input.isEmpty ? 'Masukkan angka dulu' : _check(int.tryParse(input));
      default:
        if (input.length < 10) input += label; // Batasi 10 digit agar tidak overflow
    }
  }

  // Tentukan jenis bilangan — prima dicek duluan karena prima selalu ganjil
  String _check(int? number) {
    if (number == null) return 'Input tidak valid';
    if (number < 0) return 'Masukkan bilangan positif';
    if (_isPrime(number)) return '$number adalah Bilangan Prima';
    if (number % 2 == 0) return '$number adalah Bilangan Genap';
    return '$number adalah Bilangan Ganjil';
  }

  // Cek prima dengan trial division hingga n/2 — cukup untuk input ≤ 10 digit
  bool _isPrime(int n) {
    if (n < 2) return false;
    for (int i = 2; i <= n ~/ 2; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  // Warna hasil berdasarkan konten string — merah untuk error/pesan invalid
  Color get resultColor {
    if (result.contains('Prima')) return Colors.purple;
    if (result.contains('Genap')) return Colors.blue;
    if (result.contains('Ganjil')) return Colors.orange;
    return Colors.red;
  }
}