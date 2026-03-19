import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/hijri_controller.dart';
import '../components/hijri/hijri_display_card.dart';
import '../utils/app_theme.dart';
import '../utils/input_validator.dart';

class HijriPage extends StatefulWidget {
  const HijriPage({super.key});

  @override
  State<HijriPage> createState() => _HijriPageState();
}

class _HijriPageState extends State<HijriPage> {
  final _controller = HijriController();
  final _dayCtrl = TextEditingController();
  final _yearCtrl = TextEditingController();

  DateTime _masehiDate = DateTime.now();
  int _selectedMonthIndex = 8; // Default Ramadan (Index 8)
  String _result = "";
  bool _isMasehiToHijri = true;

  void _doConversion() {
    setState(() {
      if (_isMasehiToHijri) {
        _result = _controller.convertMasehiToHijri(_masehiDate);
      } else {
        _handleHijriToMasehi();
      }
    });
  }

  void _handleHijriToMasehi() {
    // 1. Validasi field kosong
    if (_dayCtrl.text.trim().isEmpty || _yearCtrl.text.trim().isEmpty) {
      _result = "Semua field harus diisi!";
      return;
    }

    // 2. Validasi format input
    final dayErr = InputValidator.getErrorMessage(_dayCtrl.text);
    final yearErr = InputValidator.getErrorMessage(_yearCtrl.text);

    if (dayErr != null || yearErr != null) {
      _result = dayErr ?? yearErr ?? "Input tidak valid";
      return;
    }

    // Jika lolos semua validasi, baru ambil angka dan konversi
    final d = InputValidator.parseNumbers(_dayCtrl.text).numbers.first.toInt();
    final y = InputValidator.parseNumbers(_yearCtrl.text).numbers.first.toInt();

    _result = _controller.convertHijriToMasehi(d, _selectedMonthIndex + 1, y);
  }

  void _reset() {
    setState(() {
      _dayCtrl.clear();
      _yearCtrl.clear();
      _masehiDate = DateTime.now();
      _selectedMonthIndex = 8;
      _result = "";
    });
  }

  @override
  void dispose() {
    _dayCtrl.dispose();
    _yearCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        // Tombol back
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
        title: const Text('Konversi Hijriah', style: AppTheme.titleLarge),

        // Tombol refresh
        actions: [
          GestureDetector(
            onTap: _reset,
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
            // Switcher Mode
            _buildModeToggle(),
            const SizedBox(height: 20),

            // Card Input
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: _isMasehiToHijri ? _buildMasehiForm() : _buildHijriForm(),
            ),

            const SizedBox(height: 30),

            // Card penampil hasil
            HijriDisplayCard(
              title: _isMasehiToHijri ? "Hasil ke Hijriah" : "Hasil ke Masehi",
              result: _result,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeToggle() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 201, 199, 236),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: Text(
          _isMasehiToHijri ? "Masehi ➔ Hijriah" : "Hijriah ➔ Masehi",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        value: !_isMasehiToHijri,
        onChanged:
            (val) => setState(() {
              _isMasehiToHijri = !val;
              _result = "";
            }),
        activeColor: AppTheme.primary,
      ),
    );
  }

  Widget _buildMasehiForm() {
    return Column(
      children: [
        const Text("Pilih Tanggal Masehi"),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          // Pakai Outlined agar beda gaya dengan tombol utama
          icon: const Icon(Icons.calendar_month),
          label: Text(
            "${_masehiDate.day} ${_masehiDate.month} ${_masehiDate.year}",
          ),
          onPressed: () async {
            final d = await showDatePicker(
              context: context,
              initialDate: _masehiDate,
              firstDate: DateTime(1937),
              lastDate: DateTime(2077, 12, 31),
            );
            if (d != null) setState(() => _masehiDate = d);
          },
        ),
        const SizedBox(height: 20),
        _buildConversionButton(),
      ],
    );
  }

  Widget _buildHijriForm() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildTextField(_dayCtrl, "Tgl (1-30)")),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<int>(
                value: _selectedMonthIndex,
                decoration: const InputDecoration(
                  labelText: "Bulan",
                  border: OutlineInputBorder(),
                ),
                items: List.generate(
                  12,
                  (i) => DropdownMenuItem(
                    value: i,
                    child: Text(
                      _controller.hijriMonths[i],
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                onChanged: (val) => setState(() => _selectedMonthIndex = val!),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _buildTextField(_yearCtrl, "Tahun Hijriah (1356 - 1500)"),
        const SizedBox(height: 20),
        _buildConversionButton(),
      ],
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String label) {
    return TextField(
      controller: ctrl,
      // Keyboard angka muncul
      keyboardType: TextInputType.number, 
      // Membatasi hanya input angka bulat (0-9)
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildConversionButton() {
    return ElevatedButton(
      onPressed: _doConversion,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text("Konversi Sekarang"),
    );
  }
}
