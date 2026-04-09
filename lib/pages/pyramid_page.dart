import 'package:flutter/material.dart';
import '../components/pyramid/action_button.dart';
import '../components/pyramid/input_card.dart';
import '../components/pyramid/result_card.dart';
import '../controllers/pyramid_controller.dart';
import '../models/pyramid_result.dart';
import '../utils/app_theme.dart';
import '../utils/input_validator.dart';

class PyramidPage extends StatefulWidget {
  const PyramidPage({super.key});

  @override
  State<PyramidPage> createState() => _PyramidPageState();
}

class _PyramidPageState extends State<PyramidPage> {
  final _baseController = TextEditingController();
  final _heightController = TextEditingController();
  final _slantController = TextEditingController();
  final _controller = PyramidController();

  // Helper untuk cek apakah input valid (angka & tidak kosong)
  bool _isValidField(TextEditingController c) {
    final text = c.text.trim();
    if (text.isEmpty) return false;
    final val = double.tryParse(text);
    return val != null && val > 0;
  }

  // Tombol Luas & Volume aktif jika Sisi dan Tinggi valid
  // Karena Apotema sekarang otomatis, kita cukup cek Sisi & Tinggi
  bool get _canCalculate =>
      _isValidField(_baseController) && _isValidField(_heightController);

  // FUNGSI LOGIKA OTOMATIS:
  // Dipanggil setiap kali user mengetik di InputCard
  void _onInputChanged() {
    setState(() {
      final sText = _baseController.text;
      final tText = _heightController.text;
      
      final s = double.tryParse(sText);
      final t = double.tryParse(tText);

      if (s != null && t != null && s > 0 && t > 0) {
        // Panggil fungsi hitung apotema dari controller
        double apo = _controller.calculateApotemaAuto(s, t);
        _slantController.text = apo.toStringAsFixed(2);
      } else {
        // Kosongkan apotema jika input belum lengkap/valid
        _slantController.clear();
      }
      
      // Reset hasil perhitungan lama jika input berubah
      if (_controller.hasResult) {
        _controller.reset();
      }
    });
  }

  void _calculate(PyramidResult type) {
    setState(() {
      _controller.calculate(
        type,
        _baseController.text,
        _heightController.text,
      );
    });
  }

  void _resetAll() {
    setState(() {
      _baseController.clear();
      _heightController.clear();
      _slantController.clear();
      _controller.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Pyramid Calculator', style: AppTheme.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppTheme.textPrimary),
            onPressed: _resetAll,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Gambar Ilustrasi Limas
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(
                'assets/images/Square_Pyramid.png', // Pastikan path benar
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),

            // Input Card dengan listener otomatis
            InputCard(
              baseController: _baseController,
              heightController: _heightController,
              slantController: _slantController,
              onChanged: _onInputChanged, // Menghubungkan Page dengan InputCard
            ),
            const SizedBox(height: 20),

            // Menampilkan Hasil jika sudah dihitung
            if (_controller.hasResult) ...[
              ResultCard(
                result: _controller.result,
                resultLabel: _controller.resultLabel,
                isError: _controller.isError,
                activeResult: _controller.activeResult,
              ),
              const SizedBox(height: 20),
            ],

            // Baris Tombol Aksi
            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    label: 'Luas Permukaan',
                    type: PyramidResult.area,
                    activeResult: _controller.activeResult,
                    enabled: _canCalculate,
                    onTap: () => _calculate(PyramidResult.area),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ActionButton(
                    label: 'Volume',
                    type: PyramidResult.volume,
                    activeResult: _controller.activeResult,
                    enabled: _canCalculate,
                    onTap: () => _calculate(PyramidResult.volume),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}