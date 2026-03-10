import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas2/components/home/home_header.dart';
import 'package:tugas2/components/home/menu_list.dart';
import 'package:tugas2/utils/app_theme.dart';

// Halaman utama — menampilkan header dan daftar menu fitur
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Paksa status bar menjadi ikon gelap agar kontras dengan background terang
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: AppTheme.background,
      // SafeArea mencegah konten tertutup notch atau status bar
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const HomeHeader(),
              const SizedBox(height: 28),
              // Expanded agar MenuList mengisi sisa ruang layar
              Expanded(child: const MenuList()),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}