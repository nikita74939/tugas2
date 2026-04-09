import 'dart:async';
import 'package:flutter/material.dart';
import '../controllers/age_controller.dart';
import '../components/age/age_result_card.dart';
import '../utils/app_theme.dart';

class AgePage extends StatefulWidget {
  const AgePage({super.key});

  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  final _controller = AgeController();
  Timer? _timer;

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 0, minute: 0);
  int _selectedSecond = 0;
  Map<String, int>? _ageResult;

  void _calculate() {
    // Gabungkan input untuk validasi di UI
    DateTime birth = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
      _selectedSecond,
    );

    // CEK: Apakah waktu lahir lebih besar dari waktu sekarang?
    if (birth.isAfter(DateTime.now())) {
      _timer?.cancel();
      setState(
        () => _ageResult = null,
      ); // Reset hasil agar tidak muncul angka ngawur

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Hei, kamu belum lahir! 👶"),
          backgroundColor: Colors.orange, // Warna peringatan
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
      return; // Berhenti di sini, jangan lanjut hitung
    }

    // Jika sudah valid, lanjut hitung seperti biasa
    _timer?.cancel();
    setState(() {
      _ageResult = _controller.calculateAge(
        _selectedDate,
        _selectedTime,
        _selectedSecond,
      );
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _ageResult = _controller.calculateAge(
            _selectedDate,
            _selectedTime,
            _selectedSecond,
          );
        });
      }
    });
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _selectedDate = DateTime.now();
      _selectedTime = const TimeOfDay(hour: 0, minute: 0);
      _selectedSecond = 0;
      _ageResult = null;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // --- UI DIALOG INPUT DETIK (BISA NGETIK SENDIRI) ---
  void _showSecondPicker() {
    final TextEditingController secondController = TextEditingController(
      text: _selectedSecond.toString(),
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppTheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              "Masukkan Detik Lahir",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Rentang angka: 0 - 59",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: secondController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  autofocus: true,
                  maxLength: 2,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: "00",
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppTheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Batal",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  int? value = int.tryParse(secondController.text);
                  if (value != null && value >= 0 && value <= 59) {
                    setState(() => _selectedSecond = value);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Masukkan detik antara 0-59 ya!"),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Simpan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: AppTheme.primary,
              size: 20,
            ),
          ),
        ),
        title: const Text('Kalkulator Umur', style: AppTheme.titleLarge),
        actions: [
          GestureDetector(
            onTap: _reset,
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.refresh_rounded,
                color: AppTheme.primary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 10),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Tentukan Waktu Lahir",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Picker Tanggal
                  _buildPickerTile(
                    label: "Tanggal Lahir",
                    value:
                        "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                    icon: Icons.calendar_month,
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(1800),
                        lastDate: DateTime.now(),
                      );
                      if (d != null) setState(() => _selectedDate = d);
                    },
                  ),

                  const SizedBox(height: 12),

                  // Picker Jam
                  _buildPickerTile(
                    label: "Jam Lahir",
                    value: _selectedTime.format(context),
                    icon: Icons.access_time_rounded,
                    onTap: () async {
                      final t = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                      );
                      if (t != null) setState(() => _selectedTime = t);
                    },
                  ),

                  const SizedBox(height: 12),

                  // Picker Detik (Sekarang panggil _showSecondPicker yang baru)
                  _buildPickerTile(
                    label: "Detik Lahir (Opsional)",
                    value: "$_selectedSecond Detik",
                    icon: Icons.timer_outlined,
                    onTap: _showSecondPicker,
                  ),

                  const SizedBox(height: 25),

                  ElevatedButton(
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Hitung Sekarang",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            AgeResultCard(age: _ageResult),
          ],
        ),
      ),
    );
  }

  Widget _buildPickerTile({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primary, size: 22),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.edit_note, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}
