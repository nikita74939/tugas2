import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

// Jenis error yang mungkin terjadi saat kalkulasi
enum CalcError { none, divisionByZero, invalidExpression, overflow }

// Controller kalkulator — mengelola input, validasi, dan evaluasi ekspresi
class CalculatorController extends ChangeNotifier {
  String userQuestion = ''; // Ekspresi yang sedang diketik user
  String userAnswer = '';   // Hasil kalkulasi atau pesan error
  CalcError currentError = CalcError.none;

  // Titik masuk utama — semua aksi tombol diproses di sini
  void onButtonTapped(String label) {
    switch (label) {
      case 'C':
        _reset();
      case 'DEL':
        _deleteLast();
      case '=':
        _evaluate();
      default:
        _appendInput(label);
    }
    notifyListeners();
  }

  void _reset() {
    userQuestion = '';
    userAnswer = '';
    currentError = CalcError.none;
  }

  void _deleteLast() {
    if (userQuestion.isNotEmpty) {
      userQuestion = userQuestion.substring(0, userQuestion.length - 1);
      currentError = CalcError.none;
    }
  }

  void _appendInput(String label) {
    const ops = {'+', '-', '×', '÷', '%'};

    // Ganti operator terakhir jika user ketik operator baru (misal: 5+ lalu ×  → 5×)
    if (ops.contains(label) && userQuestion.isNotEmpty && ops.contains(userQuestion[userQuestion.length - 1])) {
      userQuestion = userQuestion.substring(0, userQuestion.length - 1);
    }

    // Cegah dua titik desimal dalam satu angka (misal: 3.1.4)
    if (label == '.') {
      final parts = userQuestion.split(RegExp(r'[+\-×÷%]'));
      if (parts.last.contains('.')) return;
    }

    // Cegah ekspresi diawali operator, kecuali minus untuk bilangan negatif
    if (userQuestion.isEmpty && ops.contains(label) && label != '-') return;

    currentError = CalcError.none;
    userQuestion += label;
  }

  void _evaluate() {
    if (userQuestion.isEmpty) return;

    // Ekspresi tidak boleh diakhiri operator
    const ops = {'+', '-', '×', '÷', '%'};
    if (ops.contains(userQuestion[userQuestion.length - 1])) {
      currentError = CalcError.invalidExpression;
      userAnswer = _errorMessage(currentError);
      return;
    }

    userAnswer = _calculate(userQuestion);
  }

  String _calculate(String expression) {
    try {
      // Konversi simbol kalkulator ke format yang dimengerti math_expressions
      final expr = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('%', '/100');

      // Deteksi bagi nol via regex sebelum evaluasi — lebih andal daripada cek isInfinite
      if (RegExp(r'/\s*0(\.0+)?(\s|$|[^0-9])').hasMatch(expr)) {
        currentError = CalcError.divisionByZero;
        return _errorMessage(currentError);
      }

      final result = Parser()
          .parse(expr)
          .evaluate(EvaluationType.REAL, ContextModel()) as double;

      if (result.isNaN) {
        currentError = CalcError.invalidExpression;
        return _errorMessage(currentError);
      }

      // Tangkap hasil yang terlalu besar — batas 1e15 agar tidak kehilangan presisi
      if (result.isInfinite || result.abs() > 1e15) {
        currentError = CalcError.overflow;
        return _errorMessage(currentError);
      }

      currentError = CalcError.none;
      // Tampilkan bilangan bulat tanpa desimal (misal: 6.0 → "6")
      return result % 1 == 0 ? result.toInt().toString() : result.toString();
    } catch (_) {
      currentError = CalcError.invalidExpression;
      return _errorMessage(currentError);
    }
  }

  // Pesan error yang ditampilkan ke user berdasarkan jenis error
  String _errorMessage(CalcError error) => switch (error) {
        CalcError.divisionByZero    => 'Tidak bisa bagi 0',
        CalcError.invalidExpression => 'Ekspresi tidak valid',
        CalcError.overflow          => 'Angka terlalu besar',
        CalcError.none              => '',
      };

  bool get hasError => currentError != CalcError.none;
}