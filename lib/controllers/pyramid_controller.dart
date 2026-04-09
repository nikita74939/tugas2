import 'dart:math';
import '../models/pyramid_result.dart';

class PyramidController {
  String result = '';
  String resultLabel = '';
  PyramidResult activeResult = PyramidResult.none;

  bool get hasResult => result.isNotEmpty;
  bool get isError => hasResult && resultLabel.isEmpty;

  // FUNGSI BARU: Hitung Apotema otomatis berdasarkan Tinggi & Sisi
  double calculateApotemaAuto(double base, double height) {
    // Pythagoras: s = sqrt(t^2 + (base/2)^2)
    return sqrt(pow(height, 2) + pow(base / 2, 2));
  }

  void calculate(PyramidResult type, String baseText, String heightText) {
    final base = double.tryParse(baseText);
    final height = double.tryParse(heightText);

    activeResult = type;

    // VALIDASI DASAR
    if (base == null || height == null) {
      result = 'Mohon isi semua data';
      resultLabel = '';
      return;
    }
    if (base <= 0 || height <= 0) {
      result = 'Nilai harus positif';
      resultLabel = '';
      return;
    }

    if (type == PyramidResult.volume) {
      // Rumus Volume: 1/3 * Luas Alas * Tinggi
      final volume = (1 / 3) * pow(base, 2) * height;
      result = _formatResult(volume);
      resultLabel = 'Volume';
    } else {
      // Hitung Apotema otomatis untuk Luas Permukaan
      final slant = calculateApotemaAuto(base, height);
      final baseArea = pow(base, 2).toDouble();
      // Luas 4 segitiga: 4 * (1/2 * base * slant) = 2 * base * slant
      final lateralArea = 2 * base * slant;
      final totalArea = baseArea + lateralArea;
      
      result = _formatResult(totalArea);
      resultLabel = 'Luas Permukaan';
    }
  }

  void reset() {
    result = '';
    resultLabel = '';
    activeResult = PyramidResult.none;
  }

  String _formatResult(double value) {
    return value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(2);
  }
}