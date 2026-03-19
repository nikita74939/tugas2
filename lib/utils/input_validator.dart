class InputValidator {
  static ParseResult parseNumbers(String input) {
    if (input.trim().isEmpty) {
      return ParseResult.empty();
    }

    final normalized =
        input
            .replaceAll(',', ' ')
            .replaceAll(';', ' ')
            .replaceAll('"', ' ')
            .replaceAll('\n', ' ')
            .trim();

    final tokens =
        normalized.split(RegExp(r'\s+')).where((t) => t.isNotEmpty).toList();

    final List<double> numbers = [];
    final List<InvalidToken> invalidTokens = [];

    for (int i = 0; i < tokens.length; i++) {
      final token = tokens[i];
      final parsed = double.tryParse(token);

      if (parsed != null) {
        numbers.add(parsed);
      } else {
        invalidTokens.add(InvalidToken(value: token, position: i));
      }
    }

    if (invalidTokens.isNotEmpty) {
      return ParseResult.withErrors(
        numbers: numbers,
        invalidTokens: invalidTokens,
      );
    }

    return ParseResult.success(numbers);
  }

  static bool isValidNumberInput(String input) {
    return parseNumbers(input).isFullyValid;
  }

  static String? getErrorMessage(String input) {
    final result = parseNumbers(input);

    if (result.isEmpty) return null;
    if (result.isFullyValid) return null;

    if (result.numbers.isEmpty) {
      return 'Input tidak valid. Masukkan angka saja.';
    }

    return 'Hanya angka yang diperbolehkan.';
  }
}

/// Hasil parsing input
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
  bool get isFullyValid => invalidTokens.isEmpty && numbers.isNotEmpty;
  bool get hasErrors => invalidTokens.isNotEmpty;
  bool get hasValidNumbers => numbers.isNotEmpty;
}

/// Token yang gagal diparsing
class InvalidToken {
  final String value;
  final int position;

  const InvalidToken({required this.value, required this.position});

  @override
  String toString() => 'InvalidToken(value: $value, position: $position)';
}
