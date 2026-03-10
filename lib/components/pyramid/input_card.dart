import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../utils/input_validator.dart';

// Widget kartu input untuk kalkulasi limas — mengelola validasi tiap field secara mandiri
class InputCard extends StatefulWidget {
  final TextEditingController baseController;    // Sisi alas (a)
  final TextEditingController heightController;  // Tinggi (t)
  final TextEditingController slantController;   // Apotema sisi (s)
  final VoidCallback? onChanged; // Dipanggil setiap kali input berubah — untuk update tombol di parent

  const InputCard({
    super.key,
    required this.baseController,
    required this.heightController,
    required this.slantController,
    this.onChanged,
  });

  @override
  State<InputCard> createState() => _InputCardState();
}

class _InputCardState extends State<InputCard> {
  // Pesan error per field — null berarti tidak ada error
  String? _baseError;
  String? _heightError;
  String? _slantError;

  bool _hasError(String? e) => e != null;
  bool _isEmpty(TextEditingController c) => c.text.trim().isEmpty;

  // Field valid jika tidak kosong dan tidak ada error
  bool _isValid(TextEditingController c, String? error) =>
      !_isEmpty(c) && !_hasError(error);

  // Luas permukaan butuh alas + apotema sisi (tidak butuh tinggi)
  bool get canCalculateArea =>
      _isValid(widget.baseController, _baseError) &&
      _isValid(widget.slantController, _slantError);

  // Volume butuh alas + tinggi (tidak butuh apotema sisi)
  bool get canCalculateVolume =>
      _isValid(widget.baseController, _baseError) &&
      _isValid(widget.heightController, _heightError);

  // Validasi satu field: kosong = hapus error, ada isi = cek via InputValidator
  void _validate(TextEditingController controller, void Function(String?) setError) {
    final text = controller.text;
    if (text.isEmpty) {
      setError(null);
    } else {
      final result = InputValidator.parseNumbers(text);
      setError(result.hasErrors ? 'Hanya angka yang diperbolehkan' : null);
    }
    widget.onChanged?.call();
  }

  // Dekorasi input yang dipakai bersama oleh semua field
  static InputDecoration _decoration(String hint) => InputDecoration(
        filled: true,
        fillColor: AppTheme.iconBg,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none,
        ),
        // Border biru tipis hanya muncul saat field sedang fokus
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AppTheme.primary.withOpacity(0.4),
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFFBDBDBD),
          fontWeight: FontWeight.w400,
        ),
      );

  // Membangun satu field input lengkap dengan label, input, dan banner error
  Widget _buildInput(
    String label,
    TextEditingController controller,
    String hint,
    String? errorText,
    void Function(String?) setError,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTheme.cardSubtitle),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: AppTheme.cardTitle,
          maxLines: null,
          decoration: _decoration(hint),
          onChanged: (_) => setState(() => _validate(controller, setError)),
        ),
        // Banner error hanya muncul jika errorText tidak null
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFF3B30),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.error_rounded, color: Colors.white, size: 15),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    errorText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('INPUT', style: AppTheme.titleMedium),
          const SizedBox(height: 14),
          _buildInput('Sisi Alas (a)', widget.baseController, 'Masukkan sisi alas', _baseError, (e) => _baseError = e),
          const SizedBox(height: 12),
          _buildInput('Tinggi (t)', widget.heightController, 'Masukkan tinggi', _heightError, (e) => _heightError = e),
          const SizedBox(height: 12),
          _buildInput('Apotema Sisi (s)', widget.slantController, 'Masukkan apotema sisi', _slantError, (e) => _slantError = e),
        ],
      ),
    );
  }
}