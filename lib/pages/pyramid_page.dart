import 'package:flutter/material.dart';
import '../components/pyramid/action_button.dart';
import '../components/pyramid/input_card.dart';
import '../components/pyramid/result_card.dart';
import '../controllers/pyramid_controller.dart';
import '../models/pyramid_result.dart';
import '../utils/app_theme.dart';
import '../utils/input_validator.dart';

// Halaman kalkulasi limas segiempat — luas permukaan dan volume
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

  // Field valid jika tidak kosong dan tidak mengandung karakter non-angka
  bool _isValidField(TextEditingController c) {
    final text = c.text.trim();
    if (text.isEmpty) return false;
    return !InputValidator.parseNumbers(text).hasErrors;
  }

  // Luas permukaan butuh alas + apotema; volume butuh alas + tinggi
  bool get _canArea =>
      _isValidField(_baseController) && _isValidField(_slantController);
  bool get _canVolume =>
      _isValidField(_baseController) && _isValidField(_heightController);

  void _calculate(PyramidResult type) {
    setState(() {
      _controller.calculate(
        type,
        _baseController.text,
        _heightController.text,
        _slantController.text,
      );
    });
  }

  // Reset semua field dan hasil kalkulasi sekaligus
  void _reset() {
    setState(() {
      _baseController.clear();
      _heightController.clear();
      _slantController.clear();
      _controller.reset();
    });
  }

  @override
  void dispose() {
    _baseController.dispose();
    _heightController.dispose();
    _slantController.dispose();
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
        title: const Text('Pyramid', style: AppTheme.titleLarge),
        actions: [
          // Tombol reset di AppBar — membersihkan semua input dan hasil
          GestureDetector(
            onTap: _reset,
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
              child: const Icon(
                Icons.refresh_rounded,
                color: AppTheme.primary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ilustrasi limas — membantu user memahami variabel a, t, dan s
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
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
              child: Image.asset(
                'assets/images/Square_Pyramid.png',
                height: 160,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),

            // onChanged: () => setState({}) agar _canArea & _canVolume dievaluasi ulang
            InputCard(
              baseController: _baseController,
              heightController: _heightController,
              slantController: _slantController,
              onChanged: () => setState(() {}),
            ),
            const SizedBox(height: 16),

            // ResultCard hanya ditampilkan setelah ada hasil kalkulasi
            if (_controller.hasResult) ...[
              ResultCard(
                result: _controller.result,
                resultLabel: _controller.resultLabel,
                isError: _controller.isError,
                activeResult: _controller.activeResult,
              ),
              const SizedBox(height: 16),
            ],

            // Dua tombol kalkulasi — enabled/disabled berdasarkan validitas field
            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    label: 'Luas Permukaan',
                    type: PyramidResult.area,
                    activeResult: _controller.activeResult,
                    enabled: _canArea,
                    onTap: () => _calculate(PyramidResult.area),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ActionButton(
                    label: 'Volume',
                    type: PyramidResult.volume,
                    activeResult: _controller.activeResult,
                    enabled: _canVolume,
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