import 'package:flutter/material.dart';

class FieldCounterPage extends StatefulWidget {
  const FieldCounterPage({super.key});

  @override
  State<FieldCounterPage> createState() => _FieldCounterPageState();
}

class _FieldCounterPageState extends State<FieldCounterPage> {
  final List<TextEditingController> _controllers = [TextEditingController()];
  final List<FocusNode> _focusNodes = [FocusNode()];

  void _addField() {
    setState(() {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    });
  }

  void _removeField(int index) {
    if (_controllers.length == 1) return;
    setState(() {
      _controllers[index].dispose();
      _focusNodes[index].dispose();
      _controllers.removeAt(index);
      _focusNodes.removeAt(index);
    });
  }

  void _clearAll() {
    setState(() {
      for (final c in _controllers) {
        c.clear();
      }
    });
  }

  // Ambil semua angka dari semua field (pisah per spasi/koma/newline)
  List<double> get _allNumbers {
    final List<double> numbers = [];
    for (final c in _controllers) {
      final tokens = c.text.trim().split(RegExp(r'[\s,]+'));
      for (final token in tokens) {
        final val = double.tryParse(token);
        if (val != null) numbers.add(val);
      }
    }
    return numbers;
  }

  String _fmt(double v) => v % 1 == 0 ? v.toInt().toString() : v.toStringAsFixed(2);

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final numbers = _allNumbers;
    final count = numbers.length;
    final sum = numbers.fold(0.0, (a, b) => a + b);
    final avg = count > 0 ? sum / count : 0.0;
    final min = count > 0 ? numbers.reduce((a, b) => a < b ? a : b) : 0.0;
    final max = count > 0 ? numbers.reduce((a, b) => a > b ? a : b) : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        title: const Text(
          'Field Counter',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_rounded, color: Colors.green),
            onPressed: _clearAll,
            tooltip: 'Clear semua',
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Card
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Angka', style: TextStyle(fontSize: 14, color: Colors.black54)),
                      Text(
                        '$count',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green.shade600),
                      ),
                    ],
                  ),
                  if (count > 0) ...[
                    const Divider(height: 16),
                    Row(
                      children: [
                        _statChip('Jumlah', _fmt(sum)),
                        _statChip('Rata-rata', _fmt(avg)),
                        _statChip('Min', _fmt(min)),
                        _statChip('Maks', _fmt(max)),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Field List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
              itemCount: _controllers.length,
              itemBuilder: (context, i) => _buildField(i),
            ),
          ),
        ],
      ),

      // FAB Tambah Field
      floatingActionButton: FloatingActionButton(
        onPressed: _addField,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildField(int index) {
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
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Masukkan angka (pisah dengan spasi atau koma)\nContoh: 10, 20, 30',
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                ),
              ),
            ),
            // Tombol hapus field
            if (_controllers.length > 1)
              IconButton(
                icon: Icon(Icons.remove_circle_outline, color: Colors.red.shade300, size: 20),
                onPressed: () => _removeField(index),
              ),
          ],
        ),
      ),
    );
  }

  Widget _statChip(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}