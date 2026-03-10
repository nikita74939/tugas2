import 'package:flutter/material.dart';
import 'package:tugas2/models/menu_item_model.dart';
import 'package:tugas2/pages/calculator_page.dart';
import 'package:tugas2/pages/stopwatch_page.dart';
import 'package:tugas2/pages/number_checker_page.dart';
import 'package:tugas2/pages/pyramid_page.dart';
import 'package:tugas2/pages/field_counter_page.dart';

// Controller halaman utama — menyimpan daftar fitur dan logika navigasi
class HomeController {
  // Daftar menu aplikasi — tambah fitur baru cukup di sini, UI otomatis menyesuaikan
  static const List<MenuItemModel> menus = [
    MenuItemModel(
      icon: Icons.calculate_rounded,
      label: 'Calculator',
      subtitle: 'Operasi matematika dasar',
      page: CalculatorPage(),
    ),
    MenuItemModel(
      icon: Icons.timer_rounded,
      label: 'Stopwatch',
      subtitle: 'Hitung waktu dengan lap',
      page: StopwatchPage(),
    ),
    MenuItemModel(
      icon: Icons.tag_rounded,
      label: 'Number Checker',
      subtitle: 'Cek ganjil, genap, prima',
      page: NumberCheckerPage(),
    ),
    MenuItemModel(
      icon: Icons.change_history_rounded,
      label: 'Pyramid',
      subtitle: 'Luas & volume limas',
      page: PyramidPage(),
    ),
    MenuItemModel(
      icon: Icons.list_alt_rounded,
      label: 'Field Counter',
      subtitle: 'Hitung total angka di field',
      page: FieldCounterPage(),
    ),
  ];

  // Navigasi ke halaman tujuan — terpusat di sini agar mudah diganti (misal: pakai named routes)
  static void navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }
}