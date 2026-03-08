import 'package:flutter/material.dart';

import '../components/action_button.dart';
import '../components/input_card.dart';
import '../components/pyramid_painter.dart';
import '../components/result_card.dart';
import '../controllers/pyramid_controller.dart';
import '../models/pyramid_result.dart';

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
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        title: const Text(
          'Pyramid Calculator',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.green),
            onPressed: _reset,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ilustrasi Pyramid
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 24),
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
