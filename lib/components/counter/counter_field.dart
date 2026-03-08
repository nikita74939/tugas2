import 'package:flutter/material.dart';

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nomor field
            Container(
              width: 40,
              padding: const EdgeInsets.only(top: 14),
              alignment: Alignment.topCenter,
              child: Text(
                '${index + 1}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green.shade600),
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
                decoration: InputDecoration(
                  hintText: 'Masukkan angka (pisah dengan spasi atau koma)\nContoh: 10, 20, 30',
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                ),
              ),
            ),
            // Tombol hapus field
            if (showRemove)
              IconButton(
                icon: Icon(Icons.remove_circle_outline, color: Colors.red.shade300, size: 20),
                onPressed: onRemove,
              ),
          ],
        ),
      ),
    );
  }
}