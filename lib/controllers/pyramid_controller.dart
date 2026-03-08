import 'dart:math';
import '../models/pyramid_result.dart';

class PyramidController {
  String result = '';
  String resultLabel = '';
  PyramidResult activeResult = PyramidResult.none;

  bool get hasResult => result.isNotEmpty;
  bool get isError => hasResult && resultLabel.isEmpty;

  void calculate(PyramidResult type, String baseText, String heightText, String slantText) {
    final base = double.tryParse(baseText);
    final height = double.tryParse(heightText);
    final slant = double.tryParse(slantText);

    activeResult = type;

    if (type == PyramidResult.volume) {
      if (base == null || height == null) {
        result = 'Isi alas & tinggi';
        resultLabel = '';
        return;
      }
      if (base <= 0 || height <= 0) {
        result = 'Nilai harus lebih dari 0';
        resultLabel = '';
        return;
      }
      final volume = (1 / 3) * pow(base, 2) * height;
      result = _formatResult(volume);
      resultLabel = 'Volume';
    } else {
      if (base == null || slant == null) {
        result = 'Isi alas & apotema';
        resultLabel = '';
        return;
      }
      if (base <= 0 || slant <= 0) {
        result = 'Nilai harus lebih dari 0';
        resultLabel = '';
        return;
      }
      if (slant <= base / 2) {
        result = 'Apotema terlalu kecil';
        resultLabel = '';
        return;
      }
      final baseArea = pow(base, 2).toDouble();
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