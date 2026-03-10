import 'package:flutter/material.dart';
import '../utils/input_validator.dart';

// Controller untuk mengelola daftar field input angka yang bisa ditambah/dihapus
class FieldCounterController {
  // Setiap field punya controller & focusNode masing-masing — index harus selalu sinkron
  final List<TextEditingController> controllers = [TextEditingController()];
  final List<FocusNode> focusNodes = [FocusNode()];

  // Tambah field baru di bawah — selalu dibarengi focusNode baru
  void addField() {
    controllers.add(TextEditingController());
    focusNodes.add(FocusNode());
  }

  // Hapus field berdasarkan index — minimal 1 field harus selalu ada
  void removeField(int index) {
    if (controllers.length == 1) return;
    controllers[index].dispose();
    focusNodes[index].dispose();
    controllers.removeAt(index);
    focusNodes.removeAt(index);
  }

  // Reset semua field: dispose dulu semuanya, lalu mulai ulang dengan 1 field kosong
  void clearAll() {
    for (final c in controllers) c.dispose();
    for (final f in focusNodes) f.dispose();
    controllers.clear();
    focusNodes.clear();
    controllers.add(TextEditingController());
    focusNodes.add(FocusNode());
  }

  // Wajib dipanggil saat widget dihapus agar tidak terjadi memory leak
  void dispose() {
    for (final c in controllers) c.dispose();
    for (final f in focusNodes) f.dispose();
  }

  // Kumpulkan semua angka valid dari seluruh field — angka invalid diabaikan
  List<double> get allNumbers {
    final List<double> numbers = [];
    for (final c in controllers) {
      final result = InputValidator.parseNumbers(c.text);
      numbers.addAll(result.numbers);
    }
    return numbers;
  }

  // Kembalikan pesan error untuk field tertentu — null jika input valid atau kosong
  String? errorAt(int index) {
    return InputValidator.getErrorMessage(controllers[index].text);
  }

  // True jika ada satu field atau lebih yang mengandung input tidak valid
  bool get hasAnyError {
    return controllers.any(
      (c) => InputValidator.parseNumbers(c.text).hasErrors,
    );
  }

  // Field baru hanya boleh ditambah jika field terakhir sudah terisi dan valid
  bool get canAddField {
    final lastText = controllers.last.text;
    if (lastText.trim().isEmpty) return false;
    if (InputValidator.parseNumbers(lastText).hasErrors) return false;
    return true;
  }

  // Format angka: bilangan bulat tanpa desimal, lainnya 2 angka di belakang koma
  static String fmt(double v) =>
      v % 1 == 0 ? v.toInt().toString() : v.toStringAsFixed(2);
}