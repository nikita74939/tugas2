import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

enum CalcError { none, divisionByZero, invalidExpression, overflow }

class CalculatorController extends ChangeNotifier {
  String userQuestion = '';
  String userAnswer = '';
  CalcError currentError = CalcError.none;

  // Hitung berapa kurung buka yang belum ditutup
  int get _openParens {
    int open = 0;
    for (final ch in userQuestion.characters) {
      if (ch == '(') open++;
      if (ch == ')') open--;
    }
    return open.clamp(0, 999);
  }

  void onButtonTapped(String label) {
    switch (label) {
      case 'C':
        _reset();
      case 'DEL':
        _deleteLast();
      case '=':
        _evaluate();
      case '()':
        _handleParen();
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
      // Hitung ulang preview jika ada isinya
      if (userQuestion.isNotEmpty) _tryPreview();
    } else {
      userAnswer = '';
    }
  }

  /// Logika ()
  void _handleParen() {
    const ops = {'+', '-', '×', '÷'};
    currentError = CalcError.none;

    if (userQuestion.isEmpty) {
      userQuestion += '(';
      return;
    }

    final last = userQuestion[userQuestion.length - 1];
    final afterOperatorOrOpen = ops.contains(last) || last == '(';
    final afterNumberOrClose = RegExp(r'[0-9.)]').hasMatch(last);

    if (afterOperatorOrOpen) {
      userQuestion += '(';
    } else if (afterNumberOrClose) {
      if (_openParens > 0) {
        userQuestion += ')';
      } else {
        userQuestion += '×('; // misal: 5( → 5×(
      }
    }

    _tryPreview();
  }

  void _appendInput(String label) {
    const ops = {'+', '-', '×', '÷'};

    // Jika ada error sebelumnya, reset dulu (kecuali DEL)
    if (currentError != CalcError.none) {
      currentError = CalcError.none;
    }

    final last =
        userQuestion.isNotEmpty ? userQuestion[userQuestion.length - 1] : '';

    // Aturan 2 operator, + - => -
    // Yg diambil operator terakhir
    if (ops.contains(label)) {
      if (userQuestion.isEmpty && label != '-')
        return; // awal ekspresi, hanya - boleh
      if (userQuestion.isEmpty && label == '-') {
        userQuestion += label;
        return;
      }
      if (ops.contains(last)) {
        // Replace karakter terakhir, 5x bukan 5+x
        userQuestion =
            userQuestion.substring(0, userQuestion.length - 1) + label;
        _tryPreview();
        return;
      }
      if (last == '(' && label != '-') return; //8+(-9+4)
    }

    // Titik: cegah duplikat dalam segmen angka yang sama
    if (label == '.') {
      // Ambil segmen angka terakhir (pisah berdasarkan operator & kurung)
      final segment = userQuestion.split(RegExp(r'[+\-×÷()]')).last;
      if (segment.contains('.')) return;
      if (segment.isEmpty) {
        // e.g: user ketik . lgsg jadi 0.
        userQuestion += '0';
      }
    }

    // Cegah angka nol di depan: e.g 05 -> ga boleh
    if (label == '0' && last == '0') {
      // cek apakah segmen saat ini hanya '0'
      final segment = userQuestion.split(RegExp(r'[+\-×÷()]')).last;
      if (segment == '0') return;
    }

    // Jika input angka setelah ')' -> otomatis tambah ×
    if (RegExp(r'[0-9.]').hasMatch(label) && last == ')') {
      userQuestion += '×';
    }

    currentError = CalcError.none;
    userQuestion += label;
    _tryPreview();
  }

  // Hitung preview live (ditampilkan di baris answer saat mengetik)
  void _tryPreview() {
    if (userQuestion.isEmpty) {
      userAnswer = '';
      return;
    }
    // Jangan tampilkan preview kalau ekspresi belum lengkap (diakhiri operator or kurung buka)
    final last = userQuestion[userQuestion.length - 1];
    if (RegExp(r'[+\-×÷(]').hasMatch(last)) {
      return;
    }
    // Coba evaluasi dengan menutup kurung yang masih terbuka
    final closed = userQuestion + ')' * _openParens;
    final preview = _calculate(closed, isPreview: true);
    if (currentError == CalcError.none) {
      userAnswer = preview;
    }
  }

  void _evaluate() {
    if (userQuestion.isEmpty) return;

    final last = userQuestion[userQuestion.length - 1];

    // Tutup semua kurung terbuka saat =
    userQuestion = userQuestion + ')' * _openParens;

    // Cegah evaluasi jika diakhiri operator
    if (RegExp(r'[+\-×÷(]').hasMatch(last) && _openParens == 0) {
      // Akan error ekspresi tidak valid
    }

    final result = _calculate(userQuestion);
    userAnswer = result;
    if (currentError == CalcError.none) {
      // Pindahkan hasil ke question untuk lanjut hitung
      userQuestion = result;
    }
  }

  String _calculate(String expression, {bool isPreview = false}) {
    try {
      var expr = expression.replaceAll('×', '*').replaceAll('÷', '/');

      // Deteksi pembagian dengan nol
      if (RegExp(r'/\s*0+(\.0*)?\s*([^0-9]|$)').hasMatch(expr)) {
        if (!isPreview) currentError = CalcError.divisionByZero;
        return isPreview ? '' : _errorMessage(CalcError.divisionByZero);
      }

      final result =
          Parser().parse(expr).evaluate(EvaluationType.REAL, ContextModel())
              as double;

      if (result.isNaN) {
        if (!isPreview) currentError = CalcError.invalidExpression;
        return isPreview ? '' : _errorMessage(CalcError.invalidExpression);
      }

      if (result.isInfinite) {
        if (!isPreview) currentError = CalcError.divisionByZero;
        return isPreview ? '' : _errorMessage(CalcError.divisionByZero);
      }

      if (!isPreview) currentError = CalcError.none;
      return _formatResult(result);
    } catch (_) {
      if (!isPreview) currentError = CalcError.invalidExpression;
      return isPreview ? '' : _errorMessage(CalcError.invalidExpression);
    }
  }

  String _formatResult(double result) {
    if (result % 1 == 0 && result.abs() < 1e15) {
      return result.toInt().toString();
    }
    // Angka sangat besar atau desimal panjang -> notasi e
    if (result.abs() >= 1e15 || result.abs() < 1e-10 && result != 0) {
      return result
          .toStringAsExponential(6)
          .replaceAll(RegExp(r'\.?0+(e)'), r'$1'); // trim trailing zero
    }
    // Desimal biasa -> batasi 10 digit signifikan
    final s = result.toStringAsPrecision(10);
    // Hapus trailing zero setelah titik
    if (s.contains('.')) {
      return s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }
    return s;
  }

  String _errorMessage(CalcError error) => switch (error) {
    CalcError.divisionByZero => 'Tidak bisa bagi 0',
    CalcError.invalidExpression => 'Ekspresi tidak valid',
    CalcError.overflow => 'Angka terlalu besar',
    CalcError.none => '',
  };

  bool get hasError => currentError != CalcError.none;
}
