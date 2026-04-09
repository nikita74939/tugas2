import 'package:flutter/material.dart';
import '../controllers/weton_controller.dart';
import '../components/weton/weton_result_card.dart';
import '../utils/app_theme.dart';

class WetonPage extends StatefulWidget {
  const WetonPage({super.key});

  @override
  State<WetonPage> createState() => _WetonPageState();
}

class _WetonPageState extends State<WetonPage> {
  final _controller = WetonController();
  DateTime _selectedDate = DateTime.now();
  Map<String, String>? _result;

  void _calculate() {
    setState(() {
      _result = _controller.hitungWeton(_selectedDate);
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppTheme.background,
    appBar: AppBar(
      backgroundColor: AppTheme.background,
      elevation: 0,
      title: const Text('Konversi Weton', style: AppTheme.titleLarge),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // CARD INPUT
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pilih Tanggal Kejadian", 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(1800),
                      lastDate: DateTime(2100),
                    );
                    if (d != null) {
                      setState(() {
                        _selectedDate = d;
                        // Otomatis hitung saat tanggal dipilih
                        _result = _controller.hitungWeton(d);
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_month, color: AppTheme.primary),
                        const SizedBox(width: 12),
                        Text(
                          "${_selectedDate.day} - ${_selectedDate.month} - ${_selectedDate.year}",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const Spacer(),
                        const Icon(Icons.edit_calendar, color: Colors.grey, size: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "*Hasil akan terupdate otomatis saat tanggal diubah",
                  style: TextStyle(fontSize: 11, color: Colors.grey, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          
          // HASIL (Card Component yang sudah kita buat tadi)
          WetonResultCard(hasil: _result),
          
          const SizedBox(height: 20),
          
          // Tombol Reset (Opsional)
          TextButton.icon(
            onPressed: () {
              setState(() {
                _selectedDate = DateTime.now();
                _result = null;
              });
            }, 
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text("Reset Data"),
            style: TextButton.styleFrom(foregroundColor: Colors.grey),
          )
        ],
      ),
    ),
  );
}
}