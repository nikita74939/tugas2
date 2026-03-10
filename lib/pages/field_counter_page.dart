import 'package:flutter/material.dart';
import '../controllers/field_counter_controller.dart';
import '../components/counter/summary_card.dart';
import '../components/counter/counter_field.dart';
import '../utils/app_theme.dart';

// Halaman Field Counter — input multi-field angka dengan ringkasan statistik real-time
class FieldCounterPage extends StatefulWidget {
  const FieldCounterPage({super.key});

  @override
  State<FieldCounterPage> createState() => _FieldCounterPageState();
}

class _FieldCounterPageState extends State<FieldCounterPage> {
  final _ctrl = FieldCounterController();

  // Wajib dispose controller agar TextEditingController & FocusNode tidak memory leak
  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: AppTheme.primary,
              size: 20,
            ),
          ),
        ),
        title: const Text('Field Counter', style: AppTheme.titleLarge),
        actions: [
          // Tombol clear — reset semua field ke kondisi awal (1 field kosong)
          GestureDetector(
            onTap: () => setState(() => _ctrl.clearAll()),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.delete_sweep_rounded,
                    color: AppTheme.primary,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Clear',
                    style: AppTheme.cardSubtitle.copyWith(
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 4),
          // SummaryCard otomatis update karena allNumbers dihitung ulang setiap setState
          SummaryCard(
            numbers: _ctrl.allNumbers,
            fmt: FieldCounterController.fmt,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 100), // Padding bawah agar tidak tertutup FAB
              itemCount: _ctrl.controllers.length,
              itemBuilder: (context, i) => CounterField(
                index: i,
                controller: _ctrl.controllers[i],
                focusNode: _ctrl.focusNodes[i],
                showRemove: _ctrl.controllers.length > 1, // Tombol hapus hanya jika field > 1
                onRemove: () => setState(() => _ctrl.removeField(i)),
                onChanged: () => setState(() {}), // Trigger rebuild agar SummaryCard ikut update
                errorText: _ctrl.errorAt(i),
              ),
            ),
          ),
        ],
      ),
      // FAB disabled (abu) jika field terakhir masih kosong atau invalid
      floatingActionButton: FloatingActionButton(
        onPressed: _ctrl.canAddField
            ? () => setState(() => _ctrl.addField())
            : null,
        backgroundColor: _ctrl.canAddField ? AppTheme.primary : AppTheme.iconBg,
        elevation: 4,
        child: Icon(
          Icons.add,
          color: _ctrl.canAddField ? Colors.white : AppTheme.textSecondary,
        ),
      ),
    );
  }
}