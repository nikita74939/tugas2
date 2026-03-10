import 'package:flutter/material.dart';
import 'package:tugas2/components/home/menu_card.dart';
import 'package:tugas2/controllers/home_controller.dart';

// Widget daftar menu utama — merender semua fitur/tool yang tersedia
class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil data menu dari controller — sumber kebenaran tunggal untuk daftar fitur
    final menus = HomeController.menus;

    return ListView.separated(
      physics: const BouncingScrollPhysics(), // Efek bounce saat scroll mentok ujung
      itemCount: menus.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10), // Jarak antar kartu
      itemBuilder: (context, i) => MenuCard(item: menus[i], index: i),
    );
  }
}