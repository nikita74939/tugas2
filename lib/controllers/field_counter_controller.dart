import 'package:flutter/material.dart';
import '../utils/input_validator.dart';

class FieldCounterController {
  final List<TextEditingController> controllers = [TextEditingController()];
  final List<FocusNode> focusNodes = [FocusNode()];

  void addField() {
    controllers.add(TextEditingController());
    focusNodes.add(FocusNode());
  }

  void removeField(int index) {
    if (controllers.length == 1) return;
    controllers[index].dispose();
    focusNodes[index].dispose();
    controllers.removeAt(index);
    focusNodes.removeAt(index);
  }

  /// Clear semua field dan kembali ke 1 field kosong
  void clearAll() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    controllers.clear();
    focusNodes.clear();
    controllers.add(TextEditingController());
    focusNodes.add(FocusNode());
  }

  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
  }

  /// Hanya angka valid dari semua field
  List<double> get allNumbers {
    final List<double> numbers = [];
    for (final c in controllers) {
      final result = InputValidator.parseNumbers(c.text);
      numbers.addAll(result.numbers);
    }
    return numbers;
  }

  /// Error message per field (null = tidak ada error)
  String? errorAt(int index) {
    return InputValidator.getErrorMessage(controllers[index].text);
  }

  /// True jika ada field yang punya input invalid
  bool get hasAnyError {
    return controllers.any(
      (c) => InputValidator.parseNumbers(c.text).hasErrors,
    );
  }

  /// Boleh add field hanya jika field terakhir tidak kosong dan tidak ada error
  bool get canAddField {
    final lastText = controllers.last.text;
    if (lastText.trim().isEmpty) return false;
    if (InputValidator.parseNumbers(lastText).hasErrors) return false;
    return true;
  }

  static String fmt(double v) =>
      v % 1 == 0 ? v.toInt().toString() : v.toStringAsFixed(2);
}
