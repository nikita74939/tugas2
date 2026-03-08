import 'package:flutter/material.dart';

class MenuItemModel {
  final IconData icon;
  final String label;
  final String subtitle;
  final Widget page;

  const MenuItemModel({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.page,
  });
}