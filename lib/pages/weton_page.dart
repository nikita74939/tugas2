import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class WetonPage extends StatefulWidget {
  const WetonPage({super.key});

  @override
  State<WetonPage> createState() => _WetonPageState();
}

class _WetonPageState extends State<WetonPage> {
  DateTime? _selectedDate;
  String _hari = "-";
  String _weton = "-";

  void _hitungWeton(DateTime date) {
    // Referensi: 1 Januari 1970 adalah Kamis Wage
    // Kamis (index 3 di Masehi), Wage (index 4 di Pasaran)
    final List<String> hariMasehi = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"];
    final List<String> hariPasaran = ["Kliwon", "Legi", "Pahing", "Pon", "Wage"];

    int diff = date.difference(DateTime(1970, 1, 1)).inDays;
    
    setState(() {
      _selectedDate = date;
      _hari = hariMasehi[(diff + 3) % 7];
      _weton = hariPasaran[(diff + 4) % 5];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text("Konversi Weton"),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: AppTheme.border),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text("Pilih Tanggal Lahir/Kejadian", style: AppTheme.titleMedium),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) _hitungWeton(picked);
                      },
                      icon: const Icon(Icons.calendar_today),
                      label: Text(_selectedDate == null 
                        ? "Pilih Tanggal" 
                        : "${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_selectedDate != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.primary.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Text("Hasil Konversi", style: AppTheme.cardSubtitle),
                    const SizedBox(height: 8),
                    Text("$_hari $_weton", 
                      style: AppTheme.titleLarge.copyWith(color: AppTheme.primary)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}