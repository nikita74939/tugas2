import 'package:flutter/material.dart';

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

  void clearAll() {
    for (final c in controllers) {
      c.clear();
    }
  }

  void dispose() {
    for (final c in controllers) c.dispose();
    for (final f in focusNodes) f.dispose();
  }

  List<double> get allNumbers {
    final List<double> numbers = [];
    for (final c in controllers) {
      final tokens = c.text.trim().split(RegExp(r'[\s,]+'));
      for (final token in tokens) {
        final val = double.tryParse(token);
        if (val != null) numbers.add(val);
      }
    }
    return numbers;
  }

  static String fmt(double v) =>
      v % 1 == 0 ? v.toInt().toString() : v.toStringAsFixed(2);
}