# 📱 Math Tools — Aplikasi Flutter

> Aplikasi mobile multi-fitur berbasis Flutter yang mencakup kalkulator, stopwatch, pengecekan bilangan, kalkulator limas, dan field counter, dilengkapi sistem autentikasi pengguna.

---

## 📋 Daftar Isi

- [Gambaran Umum](#-gambaran-umum)
- [Fitur Aplikasi](#-fitur-aplikasi)
- [Struktur Proyek](#-struktur-proyek)
- [Arsitektur](#-arsitektur)
- [Dokumentasi Modul](#-dokumentasi-modul)
  - [Main Entry Point](#main-entry-point)
  - [Pages (Halaman)](#pages-halaman)
  - [Controllers](#controllers)
  - [Components (Widget)](#components-widget)
  - [Models](#models)
  - [Utils](#utils)
- [Alur Navigasi](#-alur-navigasi)
- [Sistem Autentikasi](#-sistem-autentikasi)
- [Panduan Penggunaan Fitur](#-panduan-penggunaan-fitur)
- [Dependency & Package](#-dependency--package)
- [Informasi Tim](#-informasi-tim)

---

## 🌟 Gambaran Umum

**Math Tools** adalah aplikasi Flutter yang dikembangkan sebagai tugas mata kuliah **Teknologi dan Pemrograman Mobile (IF-C)**. Aplikasi ini menggabungkan beberapa alat bantu matematika dan utilitas dalam satu antarmuka yang bersih dengan desain minimalis hitam-putih.

Aplikasi dimulai dari halaman **Login**, kemudian menuju halaman **Home** yang menampilkan daftar menu fitur. Setiap fitur memiliki halaman tersendiri yang dapat diakses dengan tap.

---

## ✨ Fitur Aplikasi

| Fitur | Deskripsi |
|---|---|
| 🔐 **Login & Register** | Sistem autentikasi in-memory dengan validasi input |
| 🧮 **Calculator** | Kalkulator ekspresi matematis dengan penanganan error |
| ⏱️ **Stopwatch** | Stopwatch analog dengan fitur lap time |
| 🔢 **Number Checker** | Memeriksa apakah bilangan ganjil, genap, atau prima |
| 🔺 **Pyramid** | Menghitung luas permukaan dan volume limas segiempat |
| 📋 **Field Counter** | Menghitung statistik dari kumpulan angka multi-field |
| 👥 **Group Info** | Halaman profil kelompok + tombol logout |

---

## 📁 Struktur Proyek

```
lib/
├── main.dart                          # Entry point aplikasi
│
├── pages/                             # Halaman utama (UI layer)
│   ├── login_page.dart
│   ├── register_page.dart
│   ├── home_page.dart
│   ├── calculator_page.dart
│   ├── stopwatch_page.dart
│   ├── number_checker_page.dart
│   ├── pyramid_page.dart
│   ├── field_counter_page.dart
│   └── group_profile_page.dart
│
├── controllers/                       # Logic & state management
│   ├── home_controller.dart
│   ├── calculator_controller.dart
│   ├── stopwatch_controller.dart
│   ├── number_checker_controller.dart
│   ├── pyramid_controller.dart
│   └── field_counter_controller.dart
│
├── components/                        # Widget reusable per fitur
│   ├── auth/
│   │   └── auth_text_field.dart
│   ├── calculator/
│   │   ├── calculator_button.dart
│   │   ├── calculator_display.dart
│   │   └── calculator_keypad.dart
│   ├── counter/
│   │   ├── counter_field.dart
│   │   └── summary_card.dart
│   ├── home/
│   │   ├── home_header.dart
│   │   ├── menu_card.dart
│   │   └── menu_list.dart
│   ├── number checker/
│   │   ├── number_display.dart
│   │   └── number_keypad.dart
│   ├── pyramid/
│   │   ├── action_button.dart
│   │   ├── input_card.dart
│   │   └── result_card.dart
│   └── stopwatch/
│       ├── clock_display.dart
│       ├── clock_painter.dart
│       ├── control_buttons.dart
│       └── lap_list.dart
│
├── models/                            # Data class & enum
│   ├── auth_store.dart
│   ├── group_member.dart
│   ├── lap_data.dart
│   ├── menu_item.dart
│   ├── menu_item_model.dart
│   └── pyramid_result.dart
│
└── utils/                             # Helper & konfigurasi global
    ├── app_theme.dart
    ├── calculator_util.dart
    └── input_validator.dart
```

---

## 🏛️ Arsitektur

Aplikasi menggunakan pola arsitektur **MVC (Model-View-Controller)** yang dipadukan dengan **Provider** untuk state management reaktif pada fitur yang membutuhkannya.

```
┌─────────────┐       ┌──────────────┐     ┌──────────────┐
│    Pages     │────▶│  Controllers │────▶│    Models    │
│  (UI Layer)  │◀────│ (Logic Layer)│      │ (Data Layer) │
└─────────────┘       └──────────────┘     └──────────────┘
       │                                        │
       ▼                                        ▼
┌─────────────┐                        ┌──────────────┐
│  Components │                        │    Utils     │
│  (Widgets)  │                        │  (Helpers)   │
└─────────────┘                        └──────────────┘
```

**Dua pendekatan state management yang digunakan:**

- **`ChangeNotifier` + `Provider`** — untuk `CalculatorController` dan `StopwatchController` karena state berubah sangat sering (setiap ketukan tombol / setiap 10ms).
- **`setState`** — untuk `NumberCheckerPage`, `FieldCounterPage`, dan `PyramidPage` yang menggunakan `StatefulWidget` langsung.

---

## 📖 Dokumentasi Modul

### Main Entry Point

#### `main.dart`

File utama yang menjalankan aplikasi Flutter. Menonaktifkan debug banner dan menetapkan `LoginPage` sebagai halaman awal.

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
```

| Kelas | Tipe | Keterangan |
|---|---|---|
| `MyApp` | `StatelessWidget` | Root widget aplikasi |

---

### Pages (Halaman)

#### `login_page.dart` — `LoginPage`

Halaman login pengguna.

**State yang dikelola:**

| Variable | Tipe | Keterangan |
|---|---|---|
| `_userC` | `TextEditingController` | Input username |
| `_passC` | `TextEditingController` | Input password |
| `_error` | `String` | Pesan error yang ditampilkan |
| `_loading` | `bool` | Status loading tombol |

**Alur kerja `_login()`:**

```dart
void _login() {
  final username = _userC.text.trim();
  final password = _passC.text;

  // 1. Validasi tidak boleh kosong
  if (username.isEmpty || password.isEmpty) {
    setState(() => _error = 'Username dan password tidak boleh kosong.');
    return;
  }

  // 2. Set loading
  setState(() { _loading = true; _error = ''; });

  // 3. Simulasi delay, lalu cek ke AuthStore
  Future.delayed(const Duration(milliseconds: 400), () {
    final user = AuthStore.instance.login(username, password);
    if (!mounted) return;

    if (user != null) {
      // 4a. Berhasil → navigasi replace ke HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      // 4b. Gagal → tampilkan error
      setState(() {
        _loading = false;
        _error = 'Username atau password salah.';
      });
    }
  });
}
```

**Navigasi ke RegisterPage untuk pengguna baru:**

```dart
GestureDetector(
  onTap: () => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const RegisterPage()),
  ),
  child: const Text('Daftar', ...),
),
```

---

#### `register_page.dart` — `RegisterPage`

Halaman pendaftaran akun baru.

**Validasi bertingkat sebelum daftar:**

```dart
void _register() {
  final name     = _nameC.text.trim();
  final username = _userC.text.trim();
  final password = _passC.text;
  final confirm  = _confirmC.text;

  // Semua field wajib diisi
  if (name.isEmpty || username.isEmpty || password.isEmpty || confirm.isEmpty) {
    setState(() => _error = 'Semua field harus diisi.');
    return;
  }
  // Password harus cocok
  if (password != confirm) {
    setState(() => _error = 'Password dan konfirmasi tidak cocok.');
    return;
  }
  // Minimal 4 karakter
  if (password.length < 4) {
    setState(() => _error = 'Password minimal 4 karakter.');
    return;
  }

  setState(() { _loading = true; _error = ''; });

  Future.delayed(const Duration(milliseconds: 400), () {
    final success = AuthStore.instance.register(username, password, name);
    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text('Akun berhasil dibuat! Silakan login.')),
      );
      Navigator.pop(context); // Kembali ke LoginPage
    } else {
      setState(() {
        _loading = false;
        _error = 'Username "$username" sudah digunakan.';
      });
    }
  });
}
```

---

#### `home_page.dart` — `HomePage`

Halaman utama setelah login. Mengatur style status bar dan menyusun dua komponen utama.

```dart
@override
Widget build(BuildContext context) {
  // Paksa ikon status bar menjadi gelap (cocok dengan latar terang)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  return Scaffold(
    backgroundColor: AppTheme.background,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const HomeHeader(),              // Judul + avatar kelompok
            const SizedBox(height: 28),
            Expanded(child: const MenuList()), // Daftar menu fitur
          ],
        ),
      ),
    ),
  );
}
```

---

#### `calculator_page.dart` — `CalculatorPage`

Menyediakan `ChangeNotifierProvider` dan membagi layout menjadi dua area vertikal.

```dart
class CalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sediakan CalculatorController ke seluruh subtree
    return ChangeNotifierProvider(
      create: (_) => CalculatorController(),
      child: const _CalculatorView(),
    );
  }
}

class _CalculatorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // watch() → rebuild otomatis saat controller memanggil notifyListeners()
    final ctrl = context.watch<CalculatorController>();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1, // Area display lebih kecil
            child: CalculatorDisplay(
              question: ctrl.userQuestion,
              answer:   ctrl.userAnswer,
              hasError: ctrl.hasError,
            ),
          ),
          const Expanded(flex: 2, child: CalculatorKeypad()), // Keypad lebih besar
        ],
      ),
    );
  }
}
```

---

#### `stopwatch_page.dart` — `StopwatchPage`

Halaman stopwatch dengan tampilan jam analog. Timer diperbarui setiap **10 milidetik**.

```dart
class StopwatchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StopwatchController(),
      child: const _StopwatchView(),
    );
  }
}

class _StopwatchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<StopwatchController>();

    return Scaffold(
      body: Column(
        children: [
          ClockDisplay(
            elapsed:       ctrl.elapsed,
            formattedTime: ctrl.formatDuration(ctrl.elapsed),
          ),
          Expanded(
            child: LapList(laps: ctrl.laps, formatDuration: ctrl.formatDuration),
          ),
          ControlButtons(
            isRunning:  ctrl.isRunning,
            canReset:   ctrl.canReset,
            canLap:     ctrl.canLap,
            startPause: ctrl.startPause,
            reset:      ctrl.reset,
            lap:        ctrl.lap,
          ),
        ],
      ),
    );
  }
}
```

---

#### `number_checker_page.dart` — `NumberCheckerPage`

Menggunakan `StatefulWidget` dengan `setState` — controller dipanggil langsung tanpa Provider.

```dart
class _NumberCheckerPageState extends State<NumberCheckerPage> {
  final _ctrl = NumberCheckerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: NumberDisplay(
              input:       _ctrl.input,
              result:      _ctrl.result,
              resultColor: _ctrl.resultColor,
            ),
          ),
          Expanded(
            flex: 2,
            child: NumberKeypad(
              // setState() memanggil build ulang setelah setiap tap
              onTap: (label) => setState(() => _ctrl.onTap(label)),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

#### `pyramid_page.dart` — `PyramidPage`

Halaman perhitungan limas segiempat dengan tombol kalkulasi adaptif.

**Input yang diperlukan:**

| Field | Simbol | Digunakan Untuk |
|---|---|---|
| Sisi Alas | `a` | Volume & Luas Permukaan |
| Tinggi | `t` | Volume |
| Apotema Sisi | `s` | Luas Permukaan |

**Logika enable/disable tombol berdasarkan validasi field:**

```dart
// Helper: apakah satu field valid (tidak kosong & tidak error)?
bool _isValidField(TextEditingController c) {
  final text = c.text.trim();
  if (text.isEmpty) return false;
  return !InputValidator.parseNumbers(text).hasErrors;
}

// Tombol Luas Permukaan aktif jika alas & apotema valid
bool get _canArea =>
    _isValidField(_baseController) && _isValidField(_slantController);

// Tombol Volume aktif jika alas & tinggi valid
bool get _canVolume =>
    _isValidField(_baseController) && _isValidField(_heightController);

void _calculate(PyramidResult type) {
  setState(() {
    _controller.calculate(
      type,
      _baseController.text,
      _heightController.text,
      _slantController.text,
    );
  });
}
```

---

#### `field_counter_page.dart` — `FieldCounterPage`

Halaman penghitung angka dari beberapa field input. FAB dinonaktifkan saat field terakhir kosong/error.

```dart
class _FieldCounterPageState extends State<FieldCounterPage> {
  final _ctrl = FieldCounterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SummaryCard(numbers: _ctrl.allNumbers, fmt: FieldCounterController.fmt),
          Expanded(
            child: ListView.builder(
              itemCount: _ctrl.controllers.length,
              itemBuilder: (context, i) => CounterField(
                index:      i,
                controller: _ctrl.controllers[i],
                focusNode:  _ctrl.focusNodes[i],
                showRemove: _ctrl.controllers.length > 1,
                onRemove:   () => setState(() => _ctrl.removeField(i)),
                onChanged:  () => setState(() {}),
                errorText:  _ctrl.errorAt(i),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // Nonaktif jika field terakhir belum terisi atau masih error
        onPressed:       _ctrl.canAddField ? () => setState(() => _ctrl.addField()) : null,
        backgroundColor: _ctrl.canAddField ? AppTheme.primary : AppTheme.iconBg,
        child: Icon(Icons.add, color: _ctrl.canAddField ? Colors.white : AppTheme.textSecondary),
      ),
    );
  }
}
```

---

#### `group_profile_page.dart` — `GroupInfoPage`

Halaman informasi kelompok. Logout membersihkan seluruh navigation stack.

```dart
static const _members = [
  GroupMember(name: 'Nikita',                       nim: '123230044'),
  GroupMember(name: 'Nadhifa Alya Syafinka',        nim: '123230124'),
  GroupMember(name: 'Aisyah Nabila Nur Afifa',      nim: '123230213'),
  GroupMember(name: 'Fara Katty Sabila Al Kayyis',  nim: '123230232'),
];

void _logout(BuildContext context) {
  // pushAndRemoveUntil dengan predicate false → hapus semua route di stack
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const LoginPage()),
    (route) => false,
  );
}
```

---

### Controllers

#### `calculator_controller.dart` — `CalculatorController`

Mengatur seluruh logika kalkulator. Extends `ChangeNotifier`.

**Properties:**

| Property | Tipe | Keterangan |
|---|---|---|
| `userQuestion` | `String` | Ekspresi yang sedang diinput |
| `userAnswer` | `String` | Hasil kalkulasi atau pesan error |
| `currentError` | `CalcError` | Status error saat ini |
| `hasError` | `bool` (getter) | `true` jika ada error aktif |

**Enum `CalcError`:**

| Nilai | Kondisi |
|---|---|
| `none` | Tidak ada error |
| `divisionByZero` | Pembagian dengan nol (`/0`) |
| `invalidExpression` | Ekspresi tidak valid / diakhiri operator |
| `overflow` | Hasil melebihi `1e15` atau `Infinity` |

**Entry point semua input tombol:**

```dart
void onButtonTapped(String label) {
  switch (label) {
    case 'C':   _reset();
    case 'DEL': _deleteLast();
    case '=':   _evaluate();
    default:    _appendInput(label);
  }
  notifyListeners(); // Beritahu UI untuk rebuild
}
```

**Proteksi input `_appendInput()` — cegah ekspresi tidak valid:**

```dart
void _appendInput(String label) {
  const ops = {'+', '-', '×', '÷', '%'};

  // Cegah operator ganda (misal: 5++3, 5÷÷3)
  if (ops.contains(label) &&
      userQuestion.isNotEmpty &&
      ops.contains(userQuestion[userQuestion.length - 1])) {
    userQuestion = userQuestion.substring(0, userQuestion.length - 1);
  }

  // Cegah lebih dari satu titik desimal per angka
  if (label == '.') {
    final parts = userQuestion.split(RegExp(r'[+\-×÷%]'));
    if (parts.last.contains('.')) return;
  }

  // Cegah ekspresi diawali operator (kecuali '-' untuk bilangan negatif)
  if (userQuestion.isEmpty && ops.contains(label) && label != '-') return;

  currentError = CalcError.none;
  userQuestion += label;
}
```

**Proses kalkulasi dengan `math_expressions` dan penanganan semua jenis error:**

```dart
String _calculate(String expression) {
  try {
    // Konversi simbol ke format yang dimengerti parser
    final expr = expression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('%', '/100');

    // Deteksi pembagian dengan nol sebelum evaluasi
    if (RegExp(r'/\s*0(\.0+)?(\s|$|[^0-9])').hasMatch(expr)) {
      currentError = CalcError.divisionByZero;
      return _errorMessage(currentError);
    }

    final result = Parser()
        .parse(expr)
        .evaluate(EvaluationType.REAL, ContextModel()) as double;

    if (result.isNaN) {
      currentError = CalcError.invalidExpression;
      return _errorMessage(currentError);
    }
    if (result.isInfinite || result.abs() > 1e15) {
      currentError = CalcError.overflow;
      return _errorMessage(currentError);
    }

    currentError = CalcError.none;
    // Tampilkan integer jika bulat, desimal jika tidak
    return result % 1 == 0 ? result.toInt().toString() : result.toString();
  } catch (_) {
    currentError = CalcError.invalidExpression;
    return _errorMessage(currentError);
  }
}

String _errorMessage(CalcError error) => switch (error) {
  CalcError.divisionByZero    => 'Tidak bisa bagi 0',
  CalcError.invalidExpression => 'Ekspresi tidak valid',
  CalcError.overflow          => 'Angka terlalu besar',
  CalcError.none              => '',
};
```

---

#### `stopwatch_controller.dart` — `StopwatchController`

Mengelola logika stopwatch. Extends `ChangeNotifier`.

**Properties:**

| Property | Tipe | Keterangan |
|---|---|---|
| `elapsed` | `Duration` | Waktu berjalan sejak mulai |
| `isRunning` | `bool` | Status sedang berjalan |
| `isPaused` | `bool` | Status sedang dijeda |
| `canReset` | `bool` (getter) | Hanya bisa reset saat dijeda |
| `canLap` | `bool` (getter) | Hanya bisa lap saat berjalan |
| `laps` | `List<LapData>` | Daftar data lap (urutan terbalik) |

**Timer berjalan setiap 10ms untuk presisi centisecond:**

```dart
void _start() {
  _isRunning = true;
  _isPaused  = false;
  _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
    _elapsed += const Duration(milliseconds: 10);
    notifyListeners(); // Trigger rebuild jam analog setiap 10ms
  });
  notifyListeners();
}

void _pause() {
  _timer?.cancel();
  _isRunning = false;
  _isPaused  = true;
  notifyListeners();
}

void reset() {
  if (!canReset) return; // Hanya boleh reset saat dijeda
  _timer?.cancel();
  _elapsed  = Duration.zero;
  _lastLap  = Duration.zero;
  _isRunning = false;
  _isPaused  = false;
  _laps.clear();
  notifyListeners();
}
```

**Logika lap — menyimpan split time dan total time:**

```dart
void lap() {
  if (!canLap) return;
  final split = _elapsed - _lastLap; // Selisih dari lap sebelumnya
  _laps.add(LapData(
    index: _laps.length + 1,
    total: _elapsed,  // Waktu total dari awal
    split: split,     // Waktu segmen ini saja
  ));
  _lastLap = _elapsed;
  notifyListeners();
}

// Daftar lap dibalik agar lap terbaru tampil di atas
List<LapData> get laps => List.unmodifiable(_laps.reversed.toList());
```

**Format waktu ke string `MM:SS.cc`:**

```dart
String formatDuration(Duration d) {
  final minutes      = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds      = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  final centiseconds = (d.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(2, '0');
  return '$minutes:$seconds.$centiseconds';
}
```

---

#### `number_checker_controller.dart` — `NumberCheckerController`

Mengelola logika pengecekan bilangan. Bukan `ChangeNotifier`.

**Properties:**

| Property | Tipe | Keterangan |
|---|---|---|
| `input` | `String` | Angka yang diinput (maks 10 digit) |
| `result` | `String` | Hasil pengecekan |
| `resultColor` | `Color` (getter) | Warna teks hasil |

**Logika pengecekan — prima dicek lebih dahulu sebelum genap/ganjil:**

```dart
void onTap(String label) {
  switch (label) {
    case 'DEL':
      if (input.isNotEmpty) input = input.substring(0, input.length - 1);
      result = '';
    case 'CHECK':
      result = input.isEmpty ? 'Masukkan angka dulu' : _check(int.tryParse(input));
    default:
      if (input.length < 10) input += label; // Batas 10 digit
  }
}

String _check(int? number) {
  if (number == null) return 'Input tidak valid';
  if (number < 0)     return 'Masukkan bilangan positif';
  if (_isPrime(number)) return '$number adalah Bilangan Prima';
  if (number % 2 == 0)  return '$number adalah Bilangan Genap';
  return '$number adalah Bilangan Ganjil';
}

// Algoritma prima naif: cek pembagi dari 2 hingga n/2
bool _isPrime(int n) {
  if (n < 2) return false;
  for (int i = 2; i <= n ~/ 2; i++) {
    if (n % i == 0) return false;
  }
  return true;
}
```

**Warna teks berdasarkan jenis hasil:**

```dart
Color get resultColor {
  if (result.contains('Prima'))  return Colors.purple;
  if (result.contains('Genap'))  return Colors.blue;
  if (result.contains('Ganjil')) return Colors.orange;
  return Colors.red; // Pesan error
}
```

---

#### `pyramid_controller.dart` — `PyramidController`

Mengelola kalkulasi limas segiempat. Bukan `ChangeNotifier`.

**Properties:**

| Property | Tipe | Keterangan |
|---|---|---|
| `result` | `String` | Nilai hasil atau pesan error |
| `resultLabel` | `String` | Label ("Volume" / "Luas Permukaan") |
| `activeResult` | `PyramidResult` | Kalkulasi terakhir yang aktif |
| `hasResult` | `bool` (getter) | Ada hasil yang ditampilkan |
| `isError` | `bool` (getter) | Hasil berupa error (label kosong) |

**Rumus dan implementasi kalkulasi:**

```dart
void calculate(PyramidResult type, String baseText, String heightText, String slantText) {
  final base   = double.tryParse(baseText);
  final height = double.tryParse(heightText);
  final slant  = double.tryParse(slantText);

  activeResult = type;

  if (type == PyramidResult.volume) {
    if (base == null || height == null) { result = 'Isi alas & tinggi'; resultLabel = ''; return; }
    if (base <= 0 || height <= 0)       { result = 'Nilai harus lebih dari 0'; resultLabel = ''; return; }

    // Rumus Volume Limas Segiempat = (1/3) × a² × t
    final volume = (1 / 3) * pow(base, 2) * height;
    result = _formatResult(volume);
    resultLabel = 'Volume';

  } else { // PyramidResult.area
    if (base == null || slant == null) { result = 'Isi alas & apotema'; resultLabel = ''; return; }
    if (base <= 0 || slant <= 0)       { result = 'Nilai harus lebih dari 0'; resultLabel = ''; return; }
    if (slant <= base / 2)             { result = 'Apotema terlalu kecil'; resultLabel = ''; return; }

    // Rumus Luas Permukaan Limas = a² + (2 × a × s)
    final baseArea    = pow(base, 2).toDouble();  // Luas alas
    final lateralArea = 2 * base * slant;         // Luas 4 sisi segitiga
    result = _formatResult(baseArea + lateralArea);
    resultLabel = 'Luas Permukaan';
  }
}

String _formatResult(double value) =>
    value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(2);
```

---

#### `field_counter_controller.dart` — `FieldCounterController`

Mengelola daftar field input angka secara dinamis. Bukan `ChangeNotifier`.

**Properties:**

| Property | Tipe | Keterangan |
|---|---|---|
| `controllers` | `List<TextEditingController>` | Controller tiap field |
| `focusNodes` | `List<FocusNode>` | FocusNode tiap field |
| `allNumbers` | `List<double>` (getter) | Semua angka valid dari semua field |
| `canAddField` | `bool` (getter) | Boleh tambah field baru |

**Manajemen field secara dinamis:**

```dart
void addField() {
  controllers.add(TextEditingController());
  focusNodes.add(FocusNode());
}

void removeField(int index) {
  if (controllers.length == 1) return; // Minimal selalu 1 field
  controllers[index].dispose();
  focusNodes[index].dispose();
  controllers.removeAt(index);
  focusNodes.removeAt(index);
}

void clearAll() {
  for (final c in controllers) c.dispose();
  for (final f in focusNodes)  f.dispose();
  controllers.clear();
  focusNodes.clear();
  controllers.add(TextEditingController()); // Reset ke 1 field kosong
  focusNodes.add(FocusNode());
}
```

**Kumpulkan semua angka valid dari semua field sekaligus:**

```dart
List<double> get allNumbers {
  final List<double> numbers = [];
  for (final c in controllers) {
    final result = InputValidator.parseNumbers(c.text);
    numbers.addAll(result.numbers); // Hanya tambahkan token yang berhasil diparsing
  }
  return numbers;
}
```

**Aturan `canAddField` — field terakhir harus valid lebih dahulu:**

```dart
bool get canAddField {
  final lastText = controllers.last.text;
  if (lastText.trim().isEmpty) return false;                       // Tidak boleh kosong
  if (InputValidator.parseNumbers(lastText).hasErrors) return false; // Tidak boleh ada error
  return true;
}

// Format angka: integer jika bulat, 2 desimal jika tidak
static String fmt(double v) =>
    v % 1 == 0 ? v.toInt().toString() : v.toStringAsFixed(2);
```

---

#### `home_controller.dart` — `HomeController`

Mengelola daftar menu dan navigasi. Semua properti bersifat `static`.

```dart
class HomeController {
  static const List<MenuItemModel> menus = [
    MenuItemModel(
      icon: Icons.calculate_rounded,
      label: 'Calculator',
      subtitle: 'Operasi matematika dasar',
      page: CalculatorPage(),
    ),
    MenuItemModel(
      icon: Icons.timer_rounded,
      label: 'Stopwatch',
      subtitle: 'Hitung waktu dengan lap',
      page: StopwatchPage(),
    ),
    MenuItemModel(
      icon: Icons.tag_rounded,
      label: 'Number Checker',
      subtitle: 'Cek ganjil, genap, prima',
      page: NumberCheckerPage(),
    ),
    MenuItemModel(
      icon: Icons.change_history_rounded,
      label: 'Pyramid',
      subtitle: 'Luas & volume limas',
      page: PyramidPage(),
    ),
    MenuItemModel(
      icon: Icons.list_alt_rounded,
      label: 'Field Counter',
      subtitle: 'Hitung total angka di field',
      page: FieldCounterPage(),
    ),
  ];

  static void navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
```

---

### Components (Widget)

#### Auth Components

##### `auth_text_field.dart` — `AuthTextField`

Widget input teks untuk form autentikasi dengan fitur show/hide password.

| Parameter | Tipe | Default | Keterangan |
|---|---|---|---|
| `controller` | `TextEditingController` | wajib | Controller input |
| `label` | `String` | wajib | Label di atas field |
| `hint` | `String` | wajib | Placeholder teks |
| `isPassword` | `bool` | `false` | Aktifkan mode password |
| `keyboardType` | `TextInputType` | `text` | Tipe keyboard |

```dart
class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscure = true; // Default: password tersembunyi

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTheme.cardSubtitle),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(12), ...),
          child: TextField(
            controller:   widget.controller,
            obscureText:  widget.isPassword && _obscure, // Sembunyikan teks jika password
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              hintText: widget.hint,
              // Ikon toggle visibility hanya muncul jika isPassword = true
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                      onTap: () => setState(() => _obscure = !_obscure),
                      child: Icon(
                        _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: AppTheme.textSecondary,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
```

---

#### Calculator Components

##### `calculator_button.dart` — `MyButton`

Tombol kalkulator dengan 4 varian tampilan.

**Enum `ButtonVariant`:**

| Variant | Warna BG | Warna Teks | Contoh |
|---|---|---|---|
| `normal` | Putih | Hitam | `0`–`9`, `.` |
| `operator` | Abu terang | Hitam | `+`, `-`, `×`, `÷`, `%` |
| `action` | Abu terang | Abu | `C`, `DEL` |
| `equals` | Hitam | Putih | `=` |

```dart
Color _backgroundColor() {
  switch (variant) {
    case ButtonVariant.equals:   return AppTheme.primary;  // Hitam
    case ButtonVariant.operator: return AppTheme.iconBg;   // Abu terang
    case ButtonVariant.action:   return AppTheme.iconBg;   // Abu terang
    case ButtonVariant.normal:   return AppTheme.surface;  // Putih
  }
}

Color _foregroundColor() {
  switch (variant) {
    case ButtonVariant.equals:   return Colors.white;
    case ButtonVariant.operator: return AppTheme.textPrimary;   // Hitam
    case ButtonVariant.action:   return AppTheme.textSecondary; // Abu
    case ButtonVariant.normal:   return AppTheme.textPrimary;
  }
}

@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: buttonTapped,
    child: Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: _backgroundColor(),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(variant == ButtonVariant.equals ? 0.18 : 0.05),
            blurRadius: variant == ButtonVariant.equals ? 8 : 4,
          ),
        ],
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: variant == ButtonVariant.equals ? 26 : 20, // Tombol = lebih besar
            color: _foregroundColor(),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}
```

---

##### `calculator_display.dart` — `CalculatorDisplay`

Panel tampilan dua baris: ekspresi input (atas) dan hasil (bawah). Ukuran & warna hasil berubah sesuai kondisi error.

| Parameter | Tipe | Keterangan |
|---|---|---|
| `question` | `String` | Ekspresi input (abu, 16px) |
| `answer` | `String` | Hasil kalkulasi atau pesan error |
| `hasError` | `bool` | `true` → teks merah 20px; `false` → teks hitam 40px |

```dart
child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    // Baris atas: ekspresi yang sedang diinput
    Align(
      alignment: Alignment.centerLeft,
      child: Text(
        question.isEmpty ? '0' : question,
        style: AppTheme.cardSubtitle.copyWith(fontSize: 16, color: AppTheme.textSecondary),
      ),
    ),
    // Baris bawah: hasil kalkulasi — adaptif terhadap error
    Align(
      alignment: Alignment.centerRight,
      child: Text(
        answer,
        style: TextStyle(
          fontSize: !hasError ? 40 : 20,           // Lebih kecil jika error (teks lebih panjang)
          color:    hasError ? Colors.red.shade400 : AppTheme.textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.5,
        ),
      ),
    ),
  ],
),
```

---

##### `calculator_keypad.dart` — `CalculatorKeypad`

Layout keypad dua kolom. Kolom kiri 5×3 tombol, kolom kanan berisi DEL/−/+ dan tombol `=` tinggi.

```dart
child: Row(
  children: [
    // Kolom kiri (flex 3): 5 baris × 3 tombol dari leftButtons
    Expanded(
      flex: 3,
      child: Column(
        children: leftButtons
            .map((row) => _buildRow(context, row))
            .toList(),
      ),
    ),
    // Kolom kanan (flex 1): DEL, -, +, lalu tombol = dua kali lebih tinggi
    Expanded(
      flex: 1,
      child: Column(
        children: [
          ...['DEL', '-', '+'].map((l) => _buildSingle(context, l)),
          Expanded(
            flex: 2,
            child: MyButton(
              buttonText: '=',
              variant: ButtonVariant.equals,
              buttonTapped: () => ctrl.onButtonTapped('='),
            ),
          ),
        ],
      ),
    ),
  ],
),
```

---

#### Counter Components

##### `counter_field.dart` — `CounterField`

Widget satu field input dengan error banner kondisional di bawahnya.

| Parameter | Tipe | Keterangan |
|---|---|---|
| `index` | `int` | Nomor urut field (ditampilkan) |
| `controller` | `TextEditingController` | Controller teks |
| `focusNode` | `FocusNode` | Focus node |
| `showRemove` | `bool` | Tampilkan tombol hapus (jika >1 field) |
| `onRemove` | `VoidCallback` | Callback hapus field |
| `onChanged` | `VoidCallback` | Callback perubahan teks |
| `errorText` | `String?` | Pesan error (null = tidak ada error) |

```dart
// Error banner muncul secara kondisional di bawah field input
if (errorText != null) ...[
  const SizedBox(height: 6),
  Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: const Color(0xFFFF3B30), // Merah iOS-style
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        const Icon(Icons.error_rounded, color: Colors.white, size: 15),
        const SizedBox(width: 6),
        Expanded(
          child: Text(errorText!, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ),
      ],
    ),
  ),
],
```

---

##### `summary_card.dart` — `SummaryCard`

Kartu statistik yang menghitung count, sum, avg, min, dan max langsung dari list angka.

| Parameter | Tipe | Keterangan |
|---|---|---|
| `numbers` | `List<double>` | Semua angka valid dari semua field |
| `fmt` | `String Function(double)` | Fungsi format angka |

```dart
@override
Widget build(BuildContext context) {
  // Hitung semua statistik secara langsung dari list
  final count = numbers.length;
  final sum   = numbers.fold(0.0, (a, b) => a + b);
  final avg   = count > 0 ? sum / count : 0.0;
  final min   = count > 0 ? numbers.reduce((a, b) => a < b ? a : b) : 0.0;
  final max   = count > 0 ? numbers.reduce((a, b) => a > b ? a : b) : 0.0;

  return Container(
    ...
    child: Column(
      children: [
        // Jumlah data ditampilkan besar di atas
        Text('$count', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w800)),
        // Detail statistik hanya tampil jika ada data
        if (count > 0)
          Row(children: [
            _statChip('Jumlah',    fmt(sum)),
            _divider(),
            _statChip('Rata-rata', fmt(avg)),
            _divider(),
            _statChip('Min',       fmt(min)),
            _divider(),
            _statChip('Maks',      fmt(max)),
          ]),
      ],
    ),
  );
}
```

---

#### Home Components

##### `home_header.dart` — `HomeHeader`

Header halaman home dengan judul dua baris dan avatar kelompok.

```dart
@override
Widget build(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Math', style: AppTheme.titleLarge),
          Text(
            'Tools',
            style: AppTheme.titleLarge.copyWith(
              color: AppTheme.textSecondary.withOpacity(0.4), // Baris kedua transparan 40%
            ),
          ),
        ],
      ),
      _buildAvatar(context),
    ],
  );
}

Widget _buildAvatar(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const GroupInfoPage()),
    ),
    child: Container(
      width: 42, height: 42,
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.people, color: Colors.white, size: 20),
    ),
  );
}
```

---

##### `menu_card.dart` — `MenuCard`

Kartu menu dengan ikon, label, subtitle, dan indikator panah.

```dart
@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () => HomeController.navigateTo(context, item.page),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: AppTheme.cardDecoration,
      child: Row(
        children: [
          _buildIcon(),    // Kotak abu 50×50 dengan ikon Material
          const SizedBox(width: 16),
          _buildLabel(),   // Label tebal + subtitle abu (Expanded)
          _buildArrow(),   // Lingkaran hitam 28×28 dengan ikon panah putih
        ],
      ),
    ),
  );
}
```

---

##### `menu_list.dart` — `MenuList`

Daftar menu dengan scroll bouncing dan separator 10px antar item.

```dart
@override
Widget build(BuildContext context) {
  final menus = HomeController.menus;
  return ListView.separated(
    physics: const BouncingScrollPhysics(), // Efek bouncing saat scroll
    itemCount: menus.length,
    separatorBuilder: (_, __) => const SizedBox(height: 10),
    itemBuilder: (context, i) => MenuCard(item: menus[i], index: i),
  );
}
```

---

#### Number Checker Components

##### `number_display.dart` — `NumberDisplay`

Panel angka input besar di atas, hasil pengecekan dalam chip di bawah.

```dart
child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.end,
  children: [
    // Angka input — besar dan bold
    Text(
      input.isEmpty ? '0' : input,
      style: const TextStyle(
        fontSize: 52, fontWeight: FontWeight.w800,
        color: AppTheme.textPrimary, letterSpacing: -2,
      ),
    ),
    // Chip hasil — hanya tampil jika ada hasil
    Container(
      padding: hasResult
          ? const EdgeInsets.symmetric(horizontal: 18, vertical: 6)
          : EdgeInsets.zero,
      decoration: hasResult
          ? BoxDecoration(color: AppTheme.iconBg, borderRadius: BorderRadius.circular(20))
          : null,
      child: Text(
        result,
        style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600,
          color: hasResult ? AppTheme.textPrimary : Colors.transparent,
        ),
      ),
    ),
  ],
),
```

---

##### `number_keypad.dart` — `NumberKeypad`

Keypad 4×3 dengan tombol CHECK (hitam) dan DEL (ikon backspace).

```dart
static const _buttons = [
  ['7', '8', '9'],
  ['4', '5', '6'],
  ['1', '2', '3'],
  ['DEL', '0', 'CHECK'],
];

Widget _buildKey(String label) {
  final isCheck = label == 'CHECK';
  final isDel   = label == 'DEL';

  return Expanded(
    child: GestureDetector(
      onTap: () => onTap(label),
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isCheck ? AppTheme.primary : AppTheme.surface, // CHECK = hitam
          borderRadius: BorderRadius.circular(14),
          ...
        ),
        child: Center(
          child: isDel
              ? const Icon(Icons.backspace_outlined, color: AppTheme.textSecondary, size: 22)
              : Text(label, style: TextStyle(
                  fontSize: isCheck ? 15 : 22,    // CHECK lebih kecil (teks lebih panjang)
                  color: isCheck ? Colors.white : AppTheme.textPrimary,
                  fontWeight: FontWeight.w700,
                )),
        ),
      ),
    ),
  );
}
```

---

#### Pyramid Components

##### `action_button.dart` — `ActionButton`

Tombol aksi Pyramid dengan tiga state visual: disabled, active, dan idle.

| State | Kondisi | Warna BG | Warna Teks |
|---|---|---|---|
| Disabled | `enabled = false` | Abu terang | Abu muda |
| Active | `activeResult == type` | Hitam | Putih |
| Idle | Enabled tapi tidak aktif | Putih | Hitam |

```dart
@override
Widget build(BuildContext context) {
  final isActive = activeResult == type;

  Color bgColor;
  Color textColor;
  if (!enabled) {
    bgColor   = AppTheme.iconBg;
    textColor = const Color(0xFFBDBDBD); // Abu pucat
  } else if (isActive) {
    bgColor   = AppTheme.primary;        // Hitam — sedang aktif
    textColor = Colors.white;
  } else {
    bgColor   = AppTheme.surface;        // Putih — idle
    textColor = AppTheme.textPrimary;
  }

  return GestureDetector(
    onTap: enabled ? onTap : null,       // Nonaktif = tidak bisa di-tap sama sekali
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isActive && enabled ? 0.18 : 0.05),
            blurRadius: isActive && enabled ? 8 : 4,
          ),
        ],
      ),
      child: Center(child: Text(label, style: TextStyle(color: textColor, ...))),
    ),
  );
}
```

---

##### `input_card.dart` — `InputCard`

Kartu input 3 field dengan validasi real-time menggunakan `InputValidator`.

```dart
void _validate(TextEditingController controller, void Function(String?) setError) {
  final text = controller.text;
  if (text.isEmpty) {
    setError(null); // Field kosong = tidak ada error
  } else {
    final result = InputValidator.parseNumbers(text);
    // Error jika ada token yang bukan angka
    setError(result.hasErrors ? 'Hanya angka yang diperbolehkan' : null);
  }
  widget.onChanged?.call(); // Beritahu parent untuk update tombol aktif/nonaktif
}

// Dipasang di setiap TextField via onChanged
onChanged: (_) => setState(() => _validate(controller, setError)),
```

---

##### `result_card.dart` — `ResultCard`

Kartu hasil kalkulasi — latar hitam jika sukses, abu jika error.

```dart
@override
Widget build(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    decoration: BoxDecoration(
      color: isError ? const Color(0xFFF5F5F5) : AppTheme.primary,
      borderRadius: BorderRadius.circular(16),
      ...
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label kecil di atas (VOLUME / LUAS PERMUKAAN / Error)
              Text(isError ? 'Error' : resultLabel.toUpperCase(), ...),
              const SizedBox(height: 4),
              // Nilai hasil dengan satuan² atau satuan³
              Text(
                isError
                    ? result
                    : '$result satuan${activeResult == PyramidResult.volume ? '³' : '²'}',
                style: TextStyle(
                  fontSize: isError ? 16 : 24,
                  color: isError ? Colors.red : Colors.white,
                ),
              ),
            ],
          ),
        ),
        // Ikon centang (sukses) atau tanda error
        Icon(isError ? Icons.error_outline_rounded : Icons.check_rounded, ...),
      ],
    ),
  );
}
```

---

#### Stopwatch Components

##### `clock_painter.dart` — `ClockPainter`

Custom painter untuk jam analog stopwatch. Menggambar seluruh wajah jam di atas Canvas.

```dart
@override
void paint(Canvas canvas, Size size) {
  final center = Offset(size.width / 2, size.height / 2);
  final radius = size.width / 2;

  // 1. Lingkaran latar abu & dalam putih
  canvas.drawCircle(center, radius,       Paint()..color = const Color(0xFFEEEEEE));
  canvas.drawCircle(center, radius * 0.93, Paint()..color = Colors.white);

  // 2. 60 tick marks — tick pada kelipatan 5 lebih panjang dan tebal
  for (int i = 0; i < 60; i++) {
    final angle  = (i * 6) * pi / 180;
    final isMain = i % 5 == 0;
    final outer  = center + Offset(cos(angle - pi/2), sin(angle - pi/2)) * radius * 0.90;
    final inner  = center + Offset(cos(angle - pi/2), sin(angle - pi/2)) * radius * (isMain ? 0.78 : 0.85);
    tickPaint
      ..color       = isMain ? const Color(0xFF424242) : const Color(0xFFBDBDBD)
      ..strokeWidth = isMain ? 2.0 : 1.0;
    canvas.drawLine(inner, outer, tickPaint);
  }

  // 3. Arc progress detik (berputar penuh setiap 60 detik)
  final seconds    = elapsed.inMilliseconds / 1000.0;
  final sweepAngle = (seconds % 60) / 60 * 2 * pi;
  canvas.drawArc(
    Rect.fromCircle(center: center, radius: radius * 0.90),
    -pi / 2,     // Mulai dari posisi jam 12 (atas)
    sweepAngle,
    false,
    arcPaint,
  );

  // 4. Jarum detik
  final secAngle = sweepAngle - pi / 2;
  canvas.drawLine(
    center,
    center + Offset(cos(secAngle), sin(secAngle)) * radius * 0.70,
    handPaint,
  );

  // 5. Titik pusat — lingkaran hitam + titik putih di dalam
  canvas.drawCircle(center, 7, Paint()..color = const Color(0xFF212121));
  canvas.drawCircle(center, 4, Paint()..color = Colors.white);
}

// Hanya repaint saat elapsed berubah — optimasi performa penting
@override
bool shouldRepaint(ClockPainter old) => old.elapsed != elapsed;
```

---

##### `clock_display.dart` — `ClockDisplay`

Gabungan jam analog (`ClockPainter`) dan teks waktu digital dengan `FontFeature.tabularFigures`.

```dart
@override
Widget build(BuildContext context) {
  return Column(
    children: [
      // Jam analog dalam kontainer lingkaran dengan shadow
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 48),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, ...)],
        ),
        child: AspectRatio(
          aspectRatio: 1, // Selalu bulat sempurna berapapun lebar layar
          child: CustomPaint(painter: ClockPainter(elapsed)),
        ),
      ),
      const SizedBox(height: 20),
      // Teks digital — tabularFigures mencegah teks bergeser saat angka berubah
      Text(
        formattedTime,
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.5,
          fontFeatures: [FontFeature.tabularFigures()],
        ),
      ),
    ],
  );
}
```

---

##### `control_buttons.dart` — `ControlButtons`

Row tiga tombol kontrol stopwatch — Reset, Play/Pause (besar), Lap.

| Posisi | Tombol | Aktif Saat |
|---|---|---|
| Kiri | Reset (refresh icon) | `canReset` = true (saat dijeda) |
| Tengah | Play/Pause (besar) | Selalu aktif |
| Kanan | Lap (flag icon) | `canLap` = true (saat berjalan) |

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    // Tombol kiri: Reset
    _SideButton(
      icon: Icons.refresh_rounded,
      onTap: canReset ? reset : null, // null = nonaktif
      active: canReset,
    ),

    // Tombol tengah: Play/Pause (lebih besar, selalu aktif)
    GestureDetector(
      onTap: startPause,
      child: Container(
        width: 76, height: 76,
        decoration: BoxDecoration(
          color: AppTheme.primary,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 16, ...)],
        ),
        child: Icon(
          isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
          color: Colors.white, size: 36,
        ),
      ),
    ),

    // Tombol kanan: Lap
    _SideButton(
      icon: Icons.flag_outlined,
      onTap: canLap ? lap : null,
      active: canLap,
    ),
  ],
),
```

---

##### `lap_list.dart` — `LapList`

Daftar lap — lap terbaru (index 0) dengan latar hitam, lap lama dengan latar putih.

```dart
itemBuilder: (context, i) {
  final lap     = laps[i];
  final isFirst = i == 0; // Lap terbaru karena list sudah dibalik di controller

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: isFirst ? AppTheme.primary : AppTheme.surface, // Hitam vs Putih
      borderRadius: BorderRadius.circular(12),
      ...
    ),
    child: Row(
      children: [
        // Badge nomor lap
        Container(
          width: 30, height: 30,
          decoration: BoxDecoration(
            color: isFirst ? Colors.white.withOpacity(0.15) : AppTheme.iconBg,
            shape: BoxShape.circle,
          ),
          child: Text('${lap.index}', style: TextStyle(color: isFirst ? Colors.white : AppTheme.textPrimary)),
        ),
        const SizedBox(width: 12),

        // Split time (waktu segmen)
        Column(children: [
          Text('Split', style: TextStyle(color: isFirst ? Colors.white60 : AppTheme.textSecondary)),
          Text(formatDuration(lap.split), ...),
        ]),

        const Spacer(),

        // Total time (dari awal) — lebih besar
        Text(
          formatDuration(lap.total),
          style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w800,
            color: isFirst ? Colors.white : AppTheme.textPrimary,
          ),
        ),
      ],
    ),
  );
},
```

---

### Models

#### `auth_store.dart`

Menyimpan data pengguna dalam memori menggunakan pola **Singleton**.

**`UserModel`** — Data class pengguna:

| Field | Tipe | Keterangan |
|---|---|---|
| `username` | `String` | Username unik |
| `password` | `String` | Password (plain text) |
| `name` | `String` | Nama lengkap |

```dart
class UserModel {
  final String username;
  final String password;
  final String name;
  const UserModel({required this.username, required this.password, required this.name});
}
```

**`AuthStore`** — Singleton dengan akun admin bawaan:

```dart
class AuthStore {
  AuthStore._(); // Private constructor — tidak bisa diinstansiasi dari luar
  static final AuthStore instance = AuthStore._();

  // Akun admin langsung tersedia sejak awal
  final List<UserModel> _users = [
    const UserModel(username: 'admin', password: '1234', name: 'Administrator'),
  ];

  // Kembalikan UserModel jika cocok, null jika tidak ditemukan
  UserModel? login(String username, String password) {
    try {
      return _users.firstWhere(
        (u) => u.username == username && u.password == password,
      );
    } catch (_) {
      return null;
    }
  }

  // Daftarkan user baru; kembalikan false jika username sudah ada
  bool register(String username, String password, String name) {
    final exists = _users.any((u) => u.username == username);
    if (exists) return false;
    _users.add(UserModel(username: username, password: password, name: name));
    return true;
  }
}
```

**Akun bawaan (default):**
```
username : admin
password : 1234
```

> ⚠️ **Catatan:** Data pengguna disimpan di memori dan akan hilang ketika aplikasi ditutup.

---

#### `group_member.dart` — `GroupMember`

Data class sederhana untuk anggota kelompok.

```dart
class GroupMember {
  final String name;
  final String nim;
  const GroupMember({required this.name, required this.nim});
}
```

---

#### `lap_data.dart` — `LapData`

Data class untuk satu entri lap stopwatch.

| Field | Tipe | Keterangan |
|---|---|---|
| `index` | `int` | Nomor urut lap |
| `split` | `Duration` | Waktu selisih dari lap sebelumnya |
| `total` | `Duration` | Waktu total dari awal |

```dart
class LapData {
  final int index;
  final Duration split;
  final Duration total;
  const LapData({required this.index, required this.split, required this.total});
}
```

---

#### `menu_item_model.dart` — `MenuItemModel`

Data class untuk satu item menu di halaman home.

| Field | Tipe | Keterangan |
|---|---|---|
| `icon` | `IconData` | Ikon Material |
| `label` | `String` | Nama menu |
| `subtitle` | `String` | Deskripsi singkat |
| `page` | `Widget` | Halaman tujuan |

```dart
class MenuItemModel {
  final IconData icon;
  final String label;
  final String subtitle;
  final Widget page;

  const MenuItemModel({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.page,
  });
}
```

---

#### `pyramid_result.dart`

Enum untuk melacak jenis kalkulasi yang sedang/terakhir aktif.

```dart
enum PyramidResult { none, area, volume }
// none   → belum ada kalkulasi
// area   → menghitung Luas Permukaan
// volume → menghitung Volume
```

---

### Utils

#### `app_theme.dart` — `AppTheme`

Konfigurasi tema global. Semua nilai bersifat `const` atau `static` sehingga tidak ada alokasi memori berulang.

**Palet Warna:**

| Konstanta | Nilai | Keterangan |
|---|---|---|
| `background` | `#F5F5F5` | Latar belakang halaman |
| `surface` | `Colors.white` | Latar kartu/container |
| `primary` | `Colors.black` | Warna utama (tombol, aksen) |
| `textPrimary` | `Colors.black` | Teks utama |
| `textSecondary` | `#9E9E9E` | Teks sekunder / placeholder |
| `border` | `#E0E0E0` | Garis border |
| `iconBg` | `#F0F0F0` | Latar ikon / tombol abu |

```dart
class AppTheme {
  static const Color background    = Color(0xFFF5F5F5);
  static const Color surface       = Colors.white;
  static const Color primary       = Colors.black;
  static const Color textPrimary   = Colors.black;
  static const Color textSecondary = Color(0xFF9E9E9E);
  static const Color border        = Color(0xFFE0E0E0);
  static const Color iconBg        = Color(0xFFF0F0F0);

  static const TextStyle titleLarge = TextStyle(
    fontSize: 26, fontWeight: FontWeight.w800,
    color: textPrimary, letterSpacing: -0.5,
  );
  static const TextStyle titleMedium = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w500,
    color: textSecondary, letterSpacing: 1.2,
  );
  static const TextStyle cardTitle = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w700,
    color: textPrimary, letterSpacing: -0.2,
  );
  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 12, fontWeight: FontWeight.w400, color: textSecondary,
  );

  // BoxDecoration siap pakai — tidak perlu dibuat ulang di tiap widget
  static BoxDecoration cardDecoration = BoxDecoration(
    color: surface,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
  );
  static BoxDecoration iconDecoration = BoxDecoration(
    color: iconBg, borderRadius: BorderRadius.circular(12),
  );
}
```

---

#### `calculator_util.dart`

Konfigurasi layout tombol kalkulator — digunakan `CalculatorKeypad` untuk membangun grid dan menentukan variant.

```dart
// Set operator untuk deteksi jenis tombol di CalculatorKeypad
const operators = {'×', '÷', '-', '+', 'C', '%', 'DEL'};

// Layout 5 baris × 3 kolom untuk sisi kiri keypad
const leftButtons = [
  ['C', '÷', '×'],
  ['7', '8', '9'],
  ['4', '5', '6'],
  ['1', '2', '3'],
  ['%', '0', '.'],
];
```

Cara penggunaannya di `CalculatorKeypad`:

```dart
ButtonVariant _variantFor(String label) {
  if (label == '=')                    return ButtonVariant.equals;
  if (label == 'DEL' || label == 'AC') return ButtonVariant.action;
  if (operators.contains(label))       return ButtonVariant.operator; // Gunakan set dari sini
  return ButtonVariant.normal;
}
```

---

#### `input_validator.dart`

Utilitas parsing dan validasi input angka. Digunakan oleh `FieldCounterController`, `InputCard`, dan `PyramidPage`.

**`InputValidator` (static methods):**

| Method | Return | Keterangan |
|---|---|---|
| `parseNumbers(String input)` | `ParseResult` | Parse semua token dari input |
| `isValidNumberInput(String input)` | `bool` | `true` jika semua token valid |
| `getErrorMessage(String input)` | `String?` | Pesan error atau null |

```dart
class InputValidator {
  static ParseResult parseNumbers(String input) {
    if (input.trim().isEmpty) return ParseResult.empty();

    // Normalisasi: koma & titik koma → spasi, lalu pisah per whitespace
    final normalized = input
        .replaceAll(',', ' ')
        .replaceAll(';', ' ')
        .replaceAll('\n', ' ')
        .trim();

    final tokens = normalized.split(RegExp(r'\s+')).where((t) => t.isNotEmpty).toList();

    final List<double>       numbers       = [];
    final List<InvalidToken> invalidTokens = [];

    for (int i = 0; i < tokens.length; i++) {
      final parsed = double.tryParse(tokens[i]);
      if (parsed != null) {
        numbers.add(parsed);                                         // Token valid
      } else {
        invalidTokens.add(InvalidToken(value: tokens[i], position: i)); // Token tidak valid
      }
    }

    return invalidTokens.isNotEmpty
        ? ParseResult.withErrors(numbers: numbers, invalidTokens: invalidTokens)
        : ParseResult.success(numbers);
  }

  static String? getErrorMessage(String input) {
    final result = parseNumbers(input);
    if (result.isEmpty)      return null; // Field kosong = tidak ada error
    if (result.isFullyValid) return null; // Semua valid = tidak ada error
    if (result.numbers.isEmpty) return 'Input tidak valid. Masukkan angka saja.';
    return 'Hanya angka yang diperbolehkan.';
  }
}
```

**`ParseResult` — Hasil parsing dengan detail per token:**

```dart
class ParseResult {
  final List<double>       numbers;        // Token yang berhasil diparsing
  final List<InvalidToken> invalidTokens;  // Token yang gagal

  bool get isEmpty         => numbers.isEmpty && invalidTokens.isEmpty;
  bool get isFullyValid    => invalidTokens.isEmpty && numbers.isNotEmpty;
  bool get hasErrors       => invalidTokens.isNotEmpty;
  bool get hasValidNumbers => numbers.isNotEmpty;
}
```

**`InvalidToken` — Detail token yang gagal diparsing:**

```dart
class InvalidToken {
  final String value;    // Teks token yang tidak valid (misal: "abc", "1.2.3")
  final int    position; // Posisi token dalam array (0-based)
}
```

---

## 🗺️ Alur Navigasi

```
LoginPage
    │
    ├─[Login berhasil]──────────────────────▶ HomePage
    │                                              │
    └─[Daftar]──▶ RegisterPage                    ├─▶ CalculatorPage
                  [Berhasil daftar]──▶ LoginPage  ├─▶ StopwatchPage
                                                   ├─▶ NumberCheckerPage
                                                   ├─▶ PyramidPage
                                                   ├─▶ FieldCounterPage
                                                   └─▶ GroupInfoPage
                                                              │
                                                         [Logout]
                                                              │
                                                              ▼
                                                         LoginPage
                                                    (stack dibersihkan)
```

---

## 🔐 Sistem Autentikasi

Autentikasi menggunakan **Singleton In-Memory Store** (`AuthStore`). Data pengguna tidak dipersist ke disk — hanya hidup selama sesi aplikasi berjalan.

**Siklus hidup:**

```
App Start
    │
    ▼
AuthStore._() dipanggil
    │
    ▼
_users diinisialisasi dengan akun admin bawaan
    │
    ▼
[Sepanjang sesi, register() dapat menambah user baru ke _users]
    │
    ▼
App Ditutup → Semua data hilang
```

**Keamanan:** Password disimpan plain text (tidak di-hash). Ini hanya cocok untuk keperluan demonstrasi/tugas.

---

## 📚 Panduan Penggunaan Fitur

### 🧮 Calculator

1. Ketuk angka dan operator untuk membentuk ekspresi.
2. Ketuk `=` untuk menghitung hasil.
3. Ketuk `C` untuk menghapus semua, `DEL` untuk menghapus satu karakter.
4. Gunakan `%` untuk persentase (misal: `50%` = `0.5`).

**Error yang mungkin muncul:**
- `Tidak bisa bagi 0` — jika mencoba membagi dengan nol.
- `Ekspresi tidak valid` — jika ekspresi berakhir dengan operator.
- `Angka terlalu besar` — jika hasil melebihi 10¹⁵.

### ⏱️ Stopwatch

1. Ketuk tombol **▶ Play** untuk mulai.
2. Ketuk **⏸ Pause** untuk menjeda.
3. Ketuk **🏁 Lap** (hanya saat berjalan) untuk merekam lap.
4. Ketuk **↺ Reset** (hanya saat dijeda) untuk mereset ke nol.

### 🔢 Number Checker

1. Masukkan angka menggunakan keypad (maks 10 digit).
2. Ketuk **CHECK** untuk memeriksa jenis bilangan.
3. Ketuk **DEL** untuk menghapus digit terakhir.

### 🔺 Pyramid

1. Masukkan nilai **Sisi Alas** (`a`).
2. Untuk **Volume**: Isi juga **Tinggi** (`t`), lalu ketuk "Volume".
3. Untuk **Luas Permukaan**: Isi juga **Apotema Sisi** (`s`), lalu ketuk "Luas Permukaan".
4. Ketuk ikon **↺ Refresh** di AppBar untuk mereset semua input.

### 📋 Field Counter

1. Masukkan angka di field pertama (pisahkan dengan spasi atau koma).
2. Ketuk **+** (FAB) untuk menambah field baru.
3. Ketuk ikon **✕** di kanan field untuk menghapus field tersebut.
4. Kartu ringkasan di atas akan otomatis menampilkan: jumlah data, total, rata-rata, min, dan maks.
5. Ketuk **Clear** di AppBar untuk mereset semua.

---

## 📦 Dependency & Package

| Package | Kegunaan |
|---|---|
| `flutter` (SDK) | Framework utama |
| `provider` | State management (`ChangeNotifier`) |
| `math_expressions` | Evaluasi ekspresi matematika pada kalkulator |
