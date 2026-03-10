import 'dart:async';
import 'package:flutter/material.dart';
import '../models/lap_data.dart';

// Controller stopwatch — mengelola timer, lap, dan state running/paused
class StopwatchController extends ChangeNotifier {
  Timer? _timer;
  Duration _elapsed = Duration.zero;  // Total waktu berjalan
  Duration _lastLap = Duration.zero;  // Waktu saat lap terakhir dicatat (untuk hitung split)
  bool _isRunning = false;
  bool _isPaused = false;
  final List<LapData> _laps = [];

  Duration get elapsed => _elapsed;
  bool get isRunning => _isRunning;
  bool get isPaused => _isPaused;
  bool get canReset => _isPaused;   // Reset hanya boleh saat stopwatch dijeda
  bool get canLap => _isRunning;    // Lap hanya boleh saat stopwatch sedang berjalan
  // Balik urutan agar lap terbaru tampil di atas, bungkus unmodifiable agar list tidak diubah luar
  List<LapData> get laps => List.unmodifiable(_laps.reversed.toList());

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
    // Tick setiap 10ms untuk tampilan centisecond yang mulus
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
    // Split = selisih waktu sejak lap terakhir (bukan total)
    final split = _elapsed - _lastLap;
    _laps.add(LapData(
      index: _laps.length + 1,
      total: _elapsed,
      split: split,
    ));
    _lastLap = _elapsed; // Perbarui titik referensi untuk lap berikutnya
    notifyListeners();
  }

  // Format durasi ke MM:SS.cc — cc adalah centisecond (1/100 detik)
  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final centiseconds = (d.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(2, '0');
    return '$minutes:$seconds.$centiseconds';
  }

  // Wajib cancel timer saat controller di-dispose agar tidak terjadi memory leak
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}