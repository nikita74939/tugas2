import 'dart:async';
import 'package:flutter/material.dart';

class LapItem {
  final int index;
  final Duration total;
  final Duration split;

  LapItem({required this.index, required this.total, required this.split});
}

class StopwatchController extends ChangeNotifier {
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  Duration _lastLap = Duration.zero;
  bool _isRunning = false;
  bool _isPaused = false;
  final List<LapItem> _laps = [];

  Duration get elapsed => _elapsed;
  bool get isRunning => _isRunning;
  bool get isPaused => _isPaused;
  bool get canReset => _isPaused;
  bool get canLap => _isRunning;
  List<LapItem> get laps => List.unmodifiable(_laps.reversed.toList());

  void startPause() {
    if (_isRunning) {
      _pause();
    } else {
      _start();
    }
  }

  void _start() {
    _isRunning = true;
    _isPaused = false;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      _elapsed += const Duration(milliseconds: 10);
      notifyListeners();
    });
    notifyListeners();
  }

  void _pause() {
    _timer?.cancel();
    _isRunning = false;
    _isPaused = true;
    notifyListeners();
  }

  void reset() {
    if (!canReset) return;
    _timer?.cancel();
    _elapsed = Duration.zero;
    _lastLap = Duration.zero;
    _isRunning = false;
    _isPaused = false;
    _laps.clear();
    notifyListeners();
  }

  void lap() {
    if (!canLap) return;
    final split = _elapsed - _lastLap;
    _laps.add(LapItem(
      index: _laps.length + 1,
      total: _elapsed,
      split: split,
    ));
    _lastLap = _elapsed;
    notifyListeners();
  }

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final centiseconds = (d.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(2, '0');
    return '$minutes:$seconds.$centiseconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}