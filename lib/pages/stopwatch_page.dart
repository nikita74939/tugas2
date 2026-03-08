import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas2/controllers/stopwatch_controller.dart';
import '../components/stopwatch/clock_display.dart';
import '../components/stopwatch/lap_list.dart';
import '../components/stopwatch/control_buttons.dart';

class StopwatchPage extends StatelessWidget {
  const StopwatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StopwatchController(),
      child: const _StopwatchView(),
    );
  }
}

class _StopwatchView extends StatelessWidget {
  const _StopwatchView();

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<StopwatchController>();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        title: const Text(
          'Stopwatch',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          ClockDisplay(
            elapsed: ctrl.elapsed,
            formattedTime: ctrl.formatDuration(ctrl.elapsed),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LapList(
              laps: ctrl.laps,
              formatDuration: ctrl.formatDuration,
            ),
          ),
          ControlButtons(
            isRunning: ctrl.isRunning,
            canReset: ctrl.canReset,
            canLap: ctrl.canLap,
            startPause: ctrl.startPause,
            reset: ctrl.reset,
            lap: ctrl.lap,
          ),
        ],
      ),
    );
  }
}