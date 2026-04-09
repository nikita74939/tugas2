import 'dart:async';
import 'package:flutter/material.dart';
import '../models/lap_data.dart';

class StopwatchController extends ChangeNotifier {
  static const Duration _maxDuration = Duration(hours: 24);

  Timer? _timer;
  Duration _elapsed = Duration.zero;
  Duration _lastLap = Duration.zero;
  bool _isRunning = false;
  bool _isPaused = false;
  final List<LapData> _laps = [];

  Duration get elapsed => _elapsed;
  bool get isRunning => _isRunning;
  bool get isPaused => _isPaused;
  bool get canReset => _isPaused;
  bool get canLap => _isRunning;
  List<LapData> get laps => List.unmodifiable(_laps.reversed.toList());

  void startPause() {
    if (_isRunning) {
      _pause();
    } else {
      _start();
    }
  }

  void _start() {
    debugSkipTo(const Duration(hours: 23, minutes: 59, seconds: 57));
    _isRunning = true;
    _isPaused = false;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      _elapsed += const Duration(milliseconds: 10);

      // Reset otomatis setelah 24 jam
      if (_elapsed >= _maxDuration) {
        _elapsed = Duration.zero;
        _lastLap = Duration.zero;
        _laps.clear();
      }

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
    _laps.add(LapData(index: _laps.length + 1, total: _elapsed, split: split));
    _lastLap = _elapsed;
    notifyListeners();
  }

  String formatDuration(Duration d) {
    final hours = d.inHours.toString().padLeft(2, '0');
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final centiseconds = (d.inMilliseconds.remainder(1000) ~/ 10)
        .toString()
        .padLeft(2, '0');
    return '$hours:$minutes:$seconds.$centiseconds';
  }

  // skip to 23:59
  void debugSkipTo(Duration d) {
    _elapsed = d;
    _lastLap = d;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
