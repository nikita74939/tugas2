import 'package:flutter/material.dart';
import '../controllers/number_checker_controller.dart';
import '../components/number checker/number_display.dart';
import '../components/number checker/number_keypad.dart';

class NumberCheckerPage extends StatefulWidget {
  const NumberCheckerPage({super.key});

  @override
  State<NumberCheckerPage> createState() => _NumberCheckerPageState();
}

class _NumberCheckerPageState extends State<NumberCheckerPage> {
  final _ctrl = NumberCheckerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        title: const Text(
          'Number Checker',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: NumberDisplay(
              input: _ctrl.input,
              result: _ctrl.result,
              resultColor: _ctrl.resultColor,
            ),
          ),
          Expanded(
            flex: 2,
            child: NumberKeypad(
              onTap: (label) => setState(() => _ctrl.onTap(label)),
            ),
          ),
        ],
      ),
    );
  }
}