import 'dart:math';
import '../models/pyramid_result.dart';

// Controller kalkulasi limas segiempat — mengelola volume dan luas permukaan
class PyramidController {
  String result = '';            // Nilai hasil atau pesan error
  String resultLabel = '';       // Label jenis hasil: 'Volume' / 'Luas Permukaan' / '' jika error
  PyramidResult activeResult = PyramidResult.none;

  bool get hasResult => result.isNotEmpty;
  // Error ditandai dengan result terisi tapi resultLabel kosong
  bool get isError => hasResult && resultLabel.isEmpty;

  void calculate(PyramidResult type, String baseText, String heightText, String slantText) {
    // Parsing dulu — null berarti input bukan angka valid
    final base = double.tryParse(baseText);
    final height = double.tryParse(heightText);
    final slant = double.tryParse(slantText);

    activeResult = type;

    if (type == PyramidResult.volume) {
      // Volume butuh alas & tinggi — apotema tidak dipakai
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
      // Rumus volume limas: V = 1/3 × a² × t
      final volume = (1 / 3) * pow(base, 2) * height;
      result = _formatResult(volume);
      resultLabel = 'Volume';
    } else {
      // Luas permukaan butuh alas & apotema sisi — tinggi tidak dipakai
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
      // Validasi geometri: apotema harus lebih besar dari setengah sisi alas
      if (slant <= base / 2) {
        result = 'Apotema terlalu kecil';
        resultLabel = '';
        return;
      }
      // Rumus luas permukaan: L = a² + 2 × a × s
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

  // Tampilkan bilangan bulat tanpa desimal, lainnya 2 angka di belakang koma
  String _formatResult(double value) {
    return value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(2);
  }
}