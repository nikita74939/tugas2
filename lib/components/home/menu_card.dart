import 'package:flutter/material.dart';
import 'package:tugas2/models/menu_item_model.dart';
import 'package:tugas2/utils/app_theme.dart';
import 'package:tugas2/controllers/home_controller.dart';

// Widget kartu menu — menampilkan satu fitur/tool yang bisa dinavigasi
class MenuCard extends StatelessWidget {
  final MenuItemModel item;  // Data menu: label, subtitle, icon, dan halaman tujuan
  final int index;           // Posisi kartu di list (bisa dipakai untuk animasi/urutan)

  const MenuCard({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Navigasi ke halaman tujuan sesuai data menu
      onTap: () => HomeController.navigateTo(context, item.page),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: AppTheme.cardDecoration,
        child: Row(
          children: [
            _buildIcon(),
            const SizedBox(width: 16),
            _buildLabel(),
            _buildArrow(),
          ],
        ),
      ),
    );
  }

  // Ikon fitur dalam kotak abu muda
  Widget _buildIcon() {
    return Container(
      width: 50,
      height: 50,
      decoration: AppTheme.iconDecoration,
      child: Icon(item.icon, color: AppTheme.primary, size: 24),
    );
  }

  // Nama dan deskripsi singkat fitur
  Widget _buildLabel() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.label, style: AppTheme.cardTitle),
          const SizedBox(height: 3),
          Text(item.subtitle, style: AppTheme.cardSubtitle),
        ],
      ),
    );
  }

  // Tombol panah sebagai indikator visual bahwa kartu bisa diklik
  Widget _buildArrow() {
    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        color: AppTheme.primary,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.arrow_forward_rounded,
        color: Colors.white,
        size: 14,
      ),
    );
  }
}