import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas2/controllers/stopwatch_controller.dart';
import '../components/stopwatch/clock_display.dart';
import '../components/stopwatch/lap_list.dart';
import '../components/stopwatch/control_buttons.dart';
import '../utils/app_theme.dart';

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
        title: const Text('Stopwatch', style: AppTheme.titleLarge),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
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
