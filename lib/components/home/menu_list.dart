import 'package:flutter/material.dart';
import 'package:tugas2/components/home/menu_card.dart';
import 'package:tugas2/controllers/home_controller.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    final menus = HomeController.menus;

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: menus.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) => MenuCard(item: menus[i], index: i),
    );
  }
}