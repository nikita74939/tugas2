import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

class CounterField extends StatelessWidget {
  final int index;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool showRemove;
  final VoidCallback onRemove;
  final VoidCallback onChanged;

  const CounterField({
    super.key,
    required this.index,
    required this.controller,
    required this.focusNode,
    required this.showRemove,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nomor field
            Container(
              width: 44,
              padding: const EdgeInsets.only(top: 14),
              alignment: Alignment.topCenter,
              child: Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: AppTheme.iconBg,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
            ),
            // Input
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (_) => onChanged(),
                style: AppTheme.cardTitle.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Masukkan angka (pisah spasi/koma)\nContoh: 10, 20, 30',
                  hintStyle: AppTheme.cardSubtitle,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
                ),
              ),
            ),
            // Tombol hapus
            if (showRemove)
              GestureDetector(
                onTap: onRemove,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppTheme.iconBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.close_rounded, color: AppTheme.textSecondary, size: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}