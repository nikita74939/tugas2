import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

enum CalcError { none, divisionByZero, invalidExpression, overflow }

class CalculatorController extends ChangeNotifier {
  String userQuestion = '';
  String userAnswer = '';
  CalcError currentError = CalcError.none;

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
    // Cegah operator ganda (misal: 5++3, 5÷÷3)
    const ops = {'+', '-', '×', '÷', '%'};
    if (ops.contains(label) && userQuestion.isNotEmpty && ops.contains(userQuestion[userQuestion.length - 1])) {
      userQuestion = userQuestion.substring(0, userQuestion.length - 1);
    }

    // Cegah lebih dari satu titik dalam angka yang sama
    if (label == '.') {
      final parts = userQuestion.split(RegExp(r'[+\-×÷%]'));
      if (parts.last.contains('.')) return;
    }

    // Cegah input jika diawali operator (kecuali minus untuk bilangan negatif)
    if (userQuestion.isEmpty && ops.contains(label) && label != '-') return;

    currentError = CalcError.none;
    userQuestion += label;
  }

  void _evaluate() {
    if (userQuestion.isEmpty) return;

    // Cegah evaluasi jika diakhiri operator
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
      final expr = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('%', '/100');

      // Deteksi pembagian dengan nol sebelum evaluasi
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

      if (result.isInfinite || result.abs() > 1e15) {
        currentError = CalcError.overflow;
        return _errorMessage(currentError);
      }

      currentError = CalcError.none;
      return result % 1 == 0 ? result.toInt().toString() : result.toString();
    } catch (_) {
      currentError = CalcError.invalidExpression;
      return _errorMessage(currentError);
    }
  }

  String _errorMessage(CalcError error) => switch (error) {
        CalcError.divisionByZero   => 'Tidak bisa bagi 0',
        CalcError.invalidExpression => 'Ekspresi tidak valid',
        CalcError.overflow         => 'Angka terlalu besar',
        CalcError.none             => '',
      };

  bool get hasError => currentError != CalcError.none;
}