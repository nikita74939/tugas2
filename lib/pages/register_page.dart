import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../models/auth_store.dart';
import '../../components/auth/auth_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameC = TextEditingController();
  final _userC = TextEditingController();
  final _passC = TextEditingController();
  final _confirmC = TextEditingController();
  String _error = '';
  bool _loading = false;

  @override
  void dispose() {
    _nameC.dispose();
    _userC.dispose();
    _passC.dispose();
    _confirmC.dispose();
    super.dispose();
  }

  void _register() {
    final name = _nameC.text.trim();
    final username = _userC.text.trim();
    final password = _passC.text;
    final confirm = _confirmC.text;

    if (name.isEmpty || username.isEmpty || password.isEmpty || confirm.isEmpty) {
      setState(() => _error = 'Semua field harus diisi.');
      return;
    }
    if (password != confirm) {
      setState(() => _error = 'Password dan konfirmasi tidak cocok.');
      return;
    }
    if (password.length < 4) {
      setState(() => _error = 'Password minimal 4 karakter.');
      return;
    }

    setState(() { _loading = true; _error = ''; });

    Future.delayed(const Duration(milliseconds: 400), () {
      final success = AuthStore.instance.register(username, password, name);
      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Akun berhasil dibuat! Silakan login.'),
            backgroundColor: AppTheme.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
        Navigator.pop(context); // kembali ke login
      } else {
        setState(() {
          _loading = false;
          _error = 'Username "$username" sudah digunakan.';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              // Back + icon
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back_rounded, color: AppTheme.primary, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Title
              Text('Buat', style: AppTheme.titleLarge),
              Text(
                'Akun',
                style: AppTheme.titleLarge.copyWith(
                  color: AppTheme.textSecondary.withOpacity(0.4),
                ),
              ),
              const SizedBox(height: 6),
              Text('DAFTAR AKUN BARU', style: AppTheme.titleMedium),

              const SizedBox(height: 36),

              // Fields
              AuthTextField(
                controller: _nameC,
                label: 'Nama Lengkap',
                hint: 'Masukkan nama lengkap',
              ),
              const SizedBox(height: 14),
              AuthTextField(
                controller: _userC,
                label: 'Username',
                hint: 'Buat username unik',
              ),
              const SizedBox(height: 14),
              AuthTextField(
                controller: _passC,
                label: 'Password',
                hint: 'Minimal 4 karakter',
                isPassword: true,
              ),
              const SizedBox(height: 14),
              AuthTextField(
                controller: _confirmC,
                label: 'Konfirmasi Password',
                hint: 'Ulangi password',
                isPassword: true,
              ),

              // Error
              if (_error.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, size: 16, color: AppTheme.textSecondary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(_error, style: AppTheme.cardSubtitle.copyWith(fontSize: 13)),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 28),

              // Register button
              GestureDetector(
                onTap: _loading ? null : _register,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: _loading
                        ? const SizedBox(
                            width: 20, height: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text(
                            'Daftar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Login link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sudah punya akun?', style: AppTheme.cardSubtitle),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}