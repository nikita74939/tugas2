import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  final bool isRunning;
  final bool canReset;
  final bool canLap;
  final VoidCallback startPause;
  final VoidCallback reset;
  final VoidCallback lap;

  const ControlButtons({
    super.key,
    required this.isRunning,
    required this.canReset,
    required this.canLap,
    required this.startPause,
    required this.reset,
    required this.lap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ControlButton(
            icon: Icons.refresh_rounded,
            onTap: canReset ? reset : null,
            active: canReset,
          ),
          GestureDetector(
            onTap: startPause,
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
                isRunning ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),
          _ControlButton(
            icon: Icons.history,
            onTap: canLap ? lap : null,
            active: canLap,
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