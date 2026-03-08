import 'package:flutter/material.dart';
import '../controllers/field_counter_controller.dart';
import '../components/summary_card.dart';
import '../components/counter_field.dart';

class FieldCounterPage extends StatefulWidget {
  const FieldCounterPage({super.key});

  @override
  State<FieldCounterPage> createState() => _FieldCounterPageState();
}

class _FieldCounterPageState extends State<FieldCounterPage> {
  final _ctrl = FieldCounterController();

  @override
  void dispose() {
    _ctrl.dispose();
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
          'Field Counter',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_rounded, color: Colors.green),
            onPressed: () => setState(() => _ctrl.clearAll()),
            tooltip: 'Clear semua',
          ),
        ],
      ),
      body: Column(
        children: [
          SummaryCard(
            numbers: _ctrl.allNumbers,
            fmt: FieldCounterController.fmt,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
              itemCount: _ctrl.controllers.length,
              itemBuilder:
                  (context, i) => CounterField(
                    index: i,
                    controller: _ctrl.controllers[i],
                    focusNode: _ctrl.focusNodes[i],
                    showRemove: _ctrl.controllers.length > 1,
                    onRemove: () => setState(() => _ctrl.removeField(i)),
                    onChanged: () => setState(() {}),
                  ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _ctrl.addField()),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
