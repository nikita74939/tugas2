import 'package:flutter/material.dart';
import '../components/pyramid/action_button.dart';
import '../components/pyramid/input_card.dart';
import '../components/pyramid/pyramid_painter.dart';
import '../components/pyramid/result_card.dart';
import '../controllers/pyramid_controller.dart';
import '../models/pyramid_result.dart';
import '../utils/app_theme.dart';

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
            // Ilustrasi Pyramid
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
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
              child: CustomPaint(
                size: const Size(double.infinity, 160),
                painter: PyramidPainter(),
              ),
            ),
            const SizedBox(height: 16),

            // Input Fields
            InputCard(
              baseController: _baseController,
              heightController: _heightController,
              slantController: _slantController,
            ),
            const SizedBox(height: 16),

            // Result Card
            if (_controller.hasResult) ...[
              ResultCard(
                result: _controller.result,
                resultLabel: _controller.resultLabel,
                isError: _controller.isError,
                activeResult: _controller.activeResult,
              ),
              const SizedBox(height: 16),
            ],

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    label: 'Luas Permukaan',
                    type: PyramidResult.area,
                    activeResult: _controller.activeResult,
                    onTap: () => _calculate(PyramidResult.area),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ActionButton(
                    label: 'Volume',
                    type: PyramidResult.volume,
                    activeResult: _controller.activeResult,
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
