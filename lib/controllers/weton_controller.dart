
class WetonController {
  final List<String> daftarHari = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"];
  final List<String> daftarWeton = ["Legi", "Pahing", "Pon", "Wage", "Kliwon"];

  Map<String, String> hitungWeton(DateTime date) {
    // Referensi: 1 Januari 1970 adalah Kamis Wage
    // Selisih hari dari epoch (1970-01-01)
    int diff = date.difference(DateTime(1970, 1, 1)).inDays;

    // Hitung Hari (Kamis adalah index 3)
    String hari = daftarHari[(diff + 3) % 7];

    // Hitung Weton (Wage adalah index 3 di list kita)
    // Rumus penyesuaian index untuk siklus 5 hari
    String weton = daftarWeton[(diff + 3) % 5];

    return {
      'hari': hari,
      'weton': weton,
    };
  }
}