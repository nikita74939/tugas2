import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';

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
      padding: const EdgeInsets.only(bottom: 36, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _SideButton(
            icon: Icons.refresh_rounded,
            onTap: canReset ? reset : null,
            active: canReset,
          ),
          // Main play/pause button
          GestureDetector(
            onTap: startPause,
            child: Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: AppTheme.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),
          _SideButton(
            icon: Icons.flag_outlined,
            onTap: canLap ? lap : null,
            active: canLap,
          ),
        ],
      ),
    );
  }
}

class _SideButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool active;

  const _SideButton({
    required this.icon,
    required this.onTap,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppTheme.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 22,
          color: active ? AppTheme.textPrimary : AppTheme.textSecondary,
        ),
      ),
    );
  }
}