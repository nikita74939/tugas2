import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../utils/input_validator.dart';

class InputCard extends StatefulWidget {
  final TextEditingController baseController;
  final TextEditingController heightController;
  final TextEditingController slantController;
  final VoidCallback? onChanged;

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
  String? _baseError;
  String? _heightError;
  String? _slantError;

  bool _hasError(String? e) => e != null;
  bool _isEmpty(TextEditingController c) => c.text.trim().isEmpty;

  /// Apakah field valid (tidak kosong dan tidak error)
  bool _isValid(TextEditingController c, String? error) =>
      !_isEmpty(c) && !_hasError(error);

  bool get canCalculateArea =>
      _isValid(widget.baseController, _baseError) &&
      _isValid(widget.slantController, _slantError);

  bool get canCalculateVolume =>
      _isValid(widget.baseController, _baseError) &&
      _isValid(widget.heightController, _heightError);

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

  static InputDecoration _decoration(String hint) => InputDecoration(
        filled: true,
        fillColor: AppTheme.iconBg,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none,
        ),
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