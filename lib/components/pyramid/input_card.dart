import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../utils/input_validator.dart';

class InputCard extends StatefulWidget {
  final TextEditingController baseController;
  final TextEditingController heightController;
  final TextEditingController slantController;
  final VoidCallback? onChanged; // Callback untuk memicu hitung otomatis di Page

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

  // Helper untuk dekorasi TextField agar seragam
  InputDecoration _decoration(String hint, String? errorText) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black26),
      filled: true,
      fillColor: const Color(0xFFF2F2F2),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      // Error style di bawah kotak
      errorText: errorText,
      errorStyle: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500),
    );
  }

  // Fungsi validasi internal saat mengetik
  void _validate(String value, String type) {
    final validation = InputValidator.parseNumbers(value);
    setState(() {
      if (type == 'base') {
        _baseError = validation.hasErrors ? "Angka tidak valid" : null;
      } else if (type == 'height') {
        _heightError = validation.hasErrors ? "Angka tidak valid" : null;
      }
    });
    
    // Panggil callback agar di Page bisa update nilai Apotema secara real-time
    if (widget.onChanged != null) widget.onChanged!();
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
          const Text('INPUT DATA', style: AppTheme.titleMedium),
          const SizedBox(height: 18),

          // 1. INPUT SISI ALAS
          Text('Sisi Alas (a)', style: AppTheme.cardSubtitle),
          const SizedBox(height: 6),
          TextField(
            controller: widget.baseController,
            keyboardType: TextInputType.number,
            decoration: _decoration('Contoh: 10', _baseError),
            onChanged: (v) => _validate(v, 'base'),
          ),

          const SizedBox(height: 16),

          // 2. INPUT TINGGI
          Text('Tinggi Limas (t)', style: AppTheme.cardSubtitle),
          const SizedBox(height: 6),
          TextField(
            controller: widget.heightController,
            keyboardType: TextInputType.number,
            decoration: _decoration('Contoh: 12', _heightError),
            onChanged: (v) => _validate(v, 'height'),
          ),

          const SizedBox(height: 16),

          // 3. DISPLAY APOTEMA (READ ONLY)
          // Bagian ini di-disable agar user tahu ini hasil hitungan sistem
          Text('Apotema Sisi (s) - Otomatis', 
            style: AppTheme.cardSubtitle.copyWith(color: AppTheme.primary)
          ),
          const SizedBox(height: 6),
          TextField(
            controller: widget.slantController,
            readOnly: true, // Tidak bisa diketik manual
            enabled: false, // Memberi efek visual "terkunci"
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            decoration: InputDecoration(
              hintText: 'Akan terhitung otomatis',
              filled: true,
              fillColor: AppTheme.primary.withOpacity(0.05),
              prefixIcon: const Icon(Icons.auto_fix_high, size: 20, color: AppTheme.primary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppTheme.primary.withOpacity(0.2)),
              ),
            ),
          ),
          
          const SizedBox(height: 10),
          const Text(
            "*Apotema dihitung menggunakan rumus Pythagoras",
            style: TextStyle(fontSize: 11, color: Colors.grey, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}