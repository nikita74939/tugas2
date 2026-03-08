import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas2/controllers/stopwatch_controller.dart';
import 'dart:math';

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
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          // Analog Clock
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: AspectRatio(
              aspectRatio: 1,
              child: CustomPaint(painter: _ClockPainter(ctrl.elapsed)),
            ),
          ),
          const SizedBox(height: 12),
          // Digital Display
          Text(
            ctrl.formatDuration(ctrl.elapsed),
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w300,
              color: Colors.green.shade500,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          // Lap List
          Expanded(
            child: ListView.builder(
              itemCount: ctrl.laps.length,
              itemBuilder: (context, i) {
                final lap = ctrl.laps[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Count ${lap.index}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            ctrl.formatDuration(lap.split),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        ctrl.formatDuration(lap.total),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Bottom Controls
          Padding(
            padding: const EdgeInsets.only(bottom: 32, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Reset (kiri) — hanya aktif saat pause
                _ControlButton(
                  icon: Icons.refresh_rounded,
                  onTap: ctrl.canReset ? ctrl.reset : null,
                  active: ctrl.canReset,
                ),
                // Start / Pause (tengah)
                GestureDetector(
                  onTap: ctrl.startPause,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      ctrl.isRunning ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
                // Lap (kanan) — hanya aktif saat running
                _ControlButton(
                  icon: Icons.history,
                  onTap: ctrl.canLap ? ctrl.lap : null,
                  active: ctrl.canLap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool active;

  const _ControlButton({
    required this.icon,
    required this.onTap,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: 32,
        color: active ? Colors.green : Colors.grey.shade400,
      ),
    );
  }
}

class _ClockPainter extends CustomPainter {
  final Duration elapsed;
  _ClockPainter(this.elapsed);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background circle
    canvas.drawCircle(center, radius, Paint()..color = Colors.white);

    // Tick marks
    final tickPaint =
        Paint()
          ..color = Colors.grey.shade400
          ..strokeWidth = 1;
    for (int i = 0; i < 60; i++) {
      final angle = (i * 6) * pi / 180;
      final isMain = i % 5 == 0;
      final outer =
          center +
          Offset(cos(angle - pi / 2), sin(angle - pi / 2)) * radius * 0.95;
      final inner =
          center +
          Offset(cos(angle - pi / 2), sin(angle - pi / 2)) *
              radius *
              (isMain ? 0.85 : 0.90);
      canvas.drawLine(
        inner,
        outer,
        tickPaint..strokeWidth = isMain ? 1.5 : 0.8,
      );
    }

    // Second hand
    final seconds = elapsed.inMilliseconds / 1000.0;
    final secAngle = (seconds * 6) * pi / 180;
    final handPaint =
        Paint()
          ..color = Colors.grey.shade700
          ..strokeWidth = 1.2
          ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center -
          Offset(cos(secAngle - pi / 2), sin(secAngle - pi / 2)) * radius * 0.2,
      center +
          Offset(cos(secAngle - pi / 2), sin(secAngle - pi / 2)) *
              radius *
              0.75,
      handPaint,
    );

    // Center dot
    canvas.drawCircle(center, 5, Paint()..color = Colors.white);
    canvas.drawCircle(
      center,
      5,
      Paint()
        ..color = Colors.grey.shade600
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(_ClockPainter old) => old.elapsed != elapsed;
}
