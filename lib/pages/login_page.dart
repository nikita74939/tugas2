import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../models/auth_store.dart';
import '../../components/auth/auth_text_field.dart';
import 'register_page.dart';
import 'home_page.dart';

// Halaman login — validasi input, autentikasi, dan navigasi ke HomePage
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userC = TextEditingController();
  final _passC = TextEditingController();
  String _error = '';    // Pesan error ditampilkan di bawah field jika tidak kosong
  bool _loading = false; // Saat true, tombol login disabled dan tampil loading spinner

  @override
  void dispose() {
    _userC.dispose();
    _passC.dispose();
    super.dispose();
  }

  void _login() {
    final username = _userC.text.trim();
    final password = _passC.text;

    // Validasi awal sebelum memanggil AuthStore
    if (username.isEmpty || password.isEmpty) {
      setState(() => _error = 'Username dan password tidak boleh kosong.');
      return;
    }

    setState(() {
      _loading = true;
      _error = '';
    });

    // Delay 400ms untuk simulasi proses autentikasi agar terasa lebih natural
    Future.delayed(const Duration(milliseconds: 400), () {
      final user = AuthStore.instance.login(username, password);
      // Cek mounted agar tidak setState setelah widget dihapus dari tree
      if (!mounted) return;

      if (user != null) {
        // pushReplacement agar LoginPage dihapus dari stack — tidak bisa di-back
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
        setState(() {
          _loading = false;
          _error = 'Username atau password salah.';
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

              // Ikon app di atas judul
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.calculate_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(height: 24),

              // Judul "Selamat Datang" — "Datang" dibuat pudar sebagai aksen visual
              Text('Selamat', style: AppTheme.titleLarge),
              Text(
                'Datang',
                style: AppTheme.titleLarge.copyWith(
                  color: AppTheme.textSecondary.withOpacity(0.4),
                ),
              ),
              const SizedBox(height: 6),
              Text('MASUK KE AKUN ANDA', style: AppTheme.titleMedium),
              const SizedBox(height: 40),

              // Input field username dan password
              AuthTextField(
                controller: _userC,
                label: 'Username',
                hint: 'Masukkan username',
              ),
              const SizedBox(height: 16),
              AuthTextField(
                controller: _passC,
                label: 'Password',
                hint: 'Masukkan password',
                isPassword: true,
              ),

              // Banner error — hanya muncul jika _error tidak kosong
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
                      const Icon(
                        Icons.info_outline_rounded,
                        size: 16,
                        color: AppTheme.textSecondary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _error,
                          style: AppTheme.cardSubtitle.copyWith(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 28),

              // Tombol login — disabled saat loading agar tidak double submit
              GestureDetector(
                onTap: _loading ? null : _login,
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
                    // Tampilkan spinner saat loading, teks "Masuk" saat idle
                    child: _loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Masuk',
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

              // Link ke halaman registrasi
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Belum punya akun?', style: AppTheme.cardSubtitle),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterPage()),
                    ),
                    child: const Text(
                      'Daftar',
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