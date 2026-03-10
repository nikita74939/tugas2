// Utilitas parsing dan validasi input angka — mendukung pemisah spasi, koma, titik koma, dan newline
class InputValidator {

  // Parse string input menjadi daftar angka valid dan token tidak valid
  static ParseResult parseNumbers(String input) {
    if (input.trim().isEmpty) {
      return ParseResult.empty();
    }

    // Normalisasi: ganti semua pemisah umum dengan spasi agar bisa di-split seragam
    final normalized = input
        .replaceAll(',', ' ')
        .replaceAll(';', ' ')
        .replaceAll('\n', ' ')
        .trim();

    // Pecah berdasarkan satu atau lebih spasi — hasil normalisasi di atas
    final tokens = normalized
        .split(RegExp(r'\s+'))
        .where((t) => t.isNotEmpty)
        .toList();

    final List<double> numbers = [];
    final List<InvalidToken> invalidTokens = [];

    for (int i = 0; i < tokens.length; i++) {
      final token = tokens[i];
      final parsed = double.tryParse(token);

      if (parsed != null) {
        numbers.add(parsed);
      } else {
        // Simpan token invalid beserta posisinya untuk kebutuhan pesan error
        invalidTokens.add(InvalidToken(value: token, position: i));
      }
    }

    if (invalidTokens.isNotEmpty) {
      return ParseResult.withErrors(numbers: numbers, invalidTokens: invalidTokens);
    }

    return ParseResult.success(numbers);
  }

  // True jika semua token valid dan setidaknya ada satu angka
  static bool isValidNumberInput(String input) {
    return parseNumbers(input).isFullyValid;
  }

  // Kembalikan pesan error siap tampil, atau null jika input kosong/valid
  static String? getErrorMessage(String input) {
    final result = parseNumbers(input);

    if (result.isEmpty) return null;      // Kosong bukan error — field belum diisi
    if (result.isFullyValid) return null;

    // Bedakan pesan: tidak ada angka sama sekali vs ada angka tapi ada token invalid
    if (result.numbers.isEmpty) {
      return 'Input tidak valid. Masukkan angka saja.';
    }

    return 'Hanya angka yang diperbolehkan.';
  }
}

// Hasil parsing — membungkus angka valid dan token invalid dalam satu objek
class ParseResult {
  final List<double> numbers;
  final List<InvalidToken> invalidTokens;

  const ParseResult._({required this.numbers, required this.invalidTokens});

  factory ParseResult.success(List<double> numbers) =>
      ParseResult._(numbers: numbers, invalidTokens: []);

  factory ParseResult.withErrors({
    required List<double> numbers,
    required List<InvalidToken> invalidTokens,
  }) => ParseResult._(numbers: numbers, invalidTokens: invalidTokens);

  factory ParseResult.empty() =>
      const ParseResult._(numbers: [], invalidTokens: []);

  bool get isEmpty => numbers.isEmpty && invalidTokens.isEmpty;
  bool get isFullyValid => invalidTokens.isEmpty && numbers.isNotEmpty; // Harus ada angka, bukan hanya "tidak ada error"
  bool get hasErrors => invalidTokens.isNotEmpty;
  bool get hasValidNumbers => numbers.isNotEmpty;
}

// Representasi satu token yang gagal diparsing — menyimpan nilai dan posisinya di input
class InvalidToken {
  final String value;
  final int position; // Index token dalam array setelah split — berguna untuk debugging

  const InvalidToken({required this.value, required this.position});

  @override
  String toString() => 'InvalidToken(value: $value, position: $position)';
}