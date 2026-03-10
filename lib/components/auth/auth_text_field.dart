import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

// Widget input teks yang bisa dipakai ulang untuk halaman autentikasi (login/register)
class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;                 // Teks label yang ditampilkan di atas field
  final String hint;                  // Teks placeholder di dalam field
  final bool isPassword;              // Jika true, teks akan disembunyikan (mode password)
  final TextInputType keyboardType;   // Jenis keyboard (email, angka, teks biasa, dll)

  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.isPassword = false,                // Default: bukan field password
    this.keyboardType = TextInputType.text, // Default: keyboard teks biasa
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {

  // Menyimpan status apakah teks password sedang disembunyikan atau tidak
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // Label di atas field
        Text(widget.label, style: AppTheme.cardSubtitle),
        const SizedBox(height: 6),

        // Container untuk memberi tampilan kartu dengan shadow
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: widget.controller,

            // Sembunyikan teks hanya jika isPassword & _obscure aktif
            obscureText: widget.isPassword && _obscure, 
            keyboardType: widget.keyboardType,
            style: AppTheme.cardTitle.copyWith(fontSize: 14),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTheme.cardSubtitle,

              // Hilangkan border bawaan TextField
              border: InputBorder.none, 
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

              // Tampilkan ikon show/hide password hanya jika isPassword = true
              suffixIcon: widget.isPassword
                  ? GestureDetector(

                    // Toggle visibilitas password
                      onTap: () => setState(() => _obscure = !_obscure), 
                      child: Icon(
                        _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: AppTheme.textSecondary,
                        size: 20,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}