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
    for (final c in controllers) c.dispose();
    for (final f in focusNodes) f.dispose();
    controllers.clear();
    focusNodes.clear();
    controllers.add(TextEditingController());
    focusNodes.add(FocusNode());
  }

  void dispose() {
    for (final c in controllers) c.dispose();
    for (final f in focusNodes) f.dispose();
  }

  // --- LOGIKA SMART COUNTER BARU ---

  /// Menghitung total unit: (Grup Angka dihitung 1) + (Karakter Lain)
  /// Contoh: "Beli 2 kaos 50000" -> Beli(4) + spasi(1) + 2(1) + spasi(1) + kaos(4) + spasi(1) + 50000(1) = 13
  int get totalSmartCounter {
    int total = 0;
    for (final c in controllers) {
      String text = c.text;
      if (text.isEmpty) continue;

      // 1. Hitung berapa banyak grup angka (misal: 123 dihitung 1)
      final numGroups = RegExp(r'\d+').allMatches(text).length;

      // 2. Hitung karakter selain angka
      final nonDigitsCount = text.replaceAll(RegExp(r'\d+'), '').length;

      total += numGroups + nonDigitsCount;
    }
    return total;
  }

  /// Menghitung murni berapa banyak grup angka yang ada
  int get totalNumberGroups {
    int total = 0;
    for (final c in controllers) {
      total += RegExp(r'\d+').allMatches(c.text).length;
    }
    return total;
  }

  /// Menghitung total kata
  int get totalWords {
    int count = 0;
    for (final c in controllers) {
      final text = c.text.trim();
      if (text.isNotEmpty) {
        count += text.split(RegExp(r'\s+')).length;
      }
    }
    return count;
  }

  /// Boleh tambah field jika field terakhir tidak kosong
  bool get canAddField {
    return controllers.last.text.trim().isNotEmpty;
  }
}
