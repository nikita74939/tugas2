import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

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

  static final _inputDecoration = InputDecoration(
    filled: true,
    fillColor: AppTheme.iconBg,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: AppTheme.primary.withOpacity(0.4),
        width: 1.5,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );

  Widget _buildInput(
    String label,
    TextEditingController controller,
    String hint,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTheme.cardSubtitle),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: AppTheme.cardTitle,
          decoration: _inputDecoration.copyWith(hintText: hint),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('INPUT', style: AppTheme.titleMedium),
          const SizedBox(height: 14),
          _buildInput('Sisi Alas (a)', baseController, '...'),
          const SizedBox(height: 12),
          _buildInput('Tinggi (t)', heightController, '...'),
          const SizedBox(height: 12),
          _buildInput('Apotema Sisi (s)', slantController, '...'),
        ],
      ),
    );
  }
}
