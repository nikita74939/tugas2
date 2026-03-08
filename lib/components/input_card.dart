import 'package:flutter/material.dart';

class InputCard extends StatelessWidget {
  final TextEditingController baseController;
  final TextEditingController heightController;
  final TextEditingController slantController;

  const InputCard({
    super.key,
    required this.baseController,
    required this.heightController,
    required this.slantController,
  });

  static const _inputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.green, width: 1.5),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );

  Widget _buildInput(String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: _inputDecoration.copyWith(hintText: hint),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Input', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          _buildInput('Sisi Alas (a)', baseController, 'Contoh: 6'),
          const SizedBox(height: 10),
          _buildInput('Tinggi (t)', heightController, 'Untuk Volume'),
          const SizedBox(height: 10),
          _buildInput('Apotema Sisi (s)', slantController, 'Untuk Luas Permukaan'),
        ],
      ),
    );
  }
}