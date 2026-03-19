// Logika konversi masehi <-> hijriah
import 'package:hijri/hijri_calendar.dart';

class HijriController {
  // List Nama bulan Hijriah
  static const List<String> _indoHijriMonths = [
    "Muharram",
    "Safar",
    "Rabi'ul Awwal",
    "Rabi'ul Akhir",
    "Jumadil Awwal",
    "Jumadil Akhir",
    "Rajab",
    "Sya'ban",
    "Ramadan",
    "Syawal",
    "Dzulqa'dah",
    "Dzulhijjah",
  ];

  // Getter untuk dropdown
  List<String> get hijriMonths => _indoHijriMonths;

  // Masehi ke Hijriah -> database Umm al-Qura (1356H - 1500H).
  String convertMasehiToHijri(DateTime date) {
    try {
      // 1. Awal Masehi (1 Muharram 1356 H)
      if (date.isBefore(DateTime(1937, 3, 14))) {
        return "Error: Database mulai 14 Maret 1937 (1356 H)";
      }

      // 2. Akhir Masehi (30 Dzulhijjah 1500 H)
      if (date.isAfter(DateTime(2077, 11, 16))) {
        return "Error: Database hanya sampai 16 Nov 2077 (1500 H)";
      }

      var hDate = HijriCalendar.fromDate(date);

      // Memastikan index bulan valid sebelum mengakses List
      if (hDate.hMonth < 1 || hDate.hMonth > 12) {
        return "Tanggal tidak tersedia di sistem";
      }

      // Mapping index bulan (1-12) ke index list (0-11)
      String monthIndo = _indoHijriMonths[hDate.hMonth - 1];

      return "${hDate.hDay} $monthIndo ${hDate.hYear} H";
    } catch (e) {
      return "Tanggal di luar jangkauan sistem";
    }
  }

  // Hijriah ke Masehi
  String convertHijriToMasehi(int hDay, int hMonth, int hYear) {
    // Range tahun Hijriah di library
    if (hYear < 1356 || hYear > 1500) {
      return "Tahun di luar jangkauan (1356 - 1500 H)";
    }

    try {
      // Cek jml hari maksimal di bulan tersebut
      int maxDays = HijriCalendar().getDaysInMonth(hYear, hMonth);

      // Validasi input tanggal terhadap siklus bulan
      if (hDay < 1) {
        return "Tanggal dimulai dari 1";
      } else if (hDay > maxDays) {
        return "Bulan ini maksimal $maxDays hari";
      }

      var gDate = HijriCalendar().hijriToGregorian(hYear, hMonth, hDay);

      // Ubah bulan masehi
      const List<String> masehiMonths = [
        "Januari",
        "Februari",
        "Maret",
        "April",
        "Mei",
        "Juni",
        "Juli",
        "Agustus",
        "September",
        "Oktober",
        "November",
        "Desember",
      ];

      // Validasi hasil konversi bulan
      if (gDate.month < 1 || gDate.month > 12) return "Gagal konversi";

      return "${gDate.day} ${masehiMonths[gDate.month - 1]} ${gDate.year}";
    } catch (e) {
      return "Format tanggal tidak valid";
    }
  }
}
