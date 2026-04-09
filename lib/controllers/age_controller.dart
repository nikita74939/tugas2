import 'package:flutter/material.dart';

class AgeController {
  Map<String, int> calculateAge(DateTime date, TimeOfDay time, int second) {
    // 1. Gabungkan input user
    DateTime birth = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
      second,
    );
    DateTime now = DateTime.now();

    // --- VALIDASI UTAMA ---
    // Jika waktu lahir ada di masa depan (misal: baru lahir jam 8 malam nanti)
    if (birth.isAfter(now)) {
      return {
        'years': 0,
        'months': 0,
        'days': 0,
        'hours': 0,
        'minutes': 0,
        'seconds': 0,
      };
    }

    // 2. Hitung selisih Durasi total untuk jam, menit, detik
    Duration diff = now.difference(birth);

    // 3. Hitung selisih Kalender (Tahun, Bulan, Hari)
    int years = now.year - birth.year;
    int months = now.month - birth.month;
    int days = now.day - birth.day;

    // Perbaikan Jam: Jika jam/menit/detik sekarang belum mencapai jam lahir,
    // maka hari harus dikurangi 1
    // Kita buat DateTime 'temp' untuk membandingkan posisi waktu saat ini
    DateTime tempBirth = DateTime(
      now.year,
      now.month,
      now.day,
      birth.hour,
      birth.minute,
      birth.second,
    );
    if (now.isBefore(tempBirth)) {
      days--;
    }

    // Logika penyesuaian hari negatif
    if (days < 0) {
      months--;
      int daysInPrevMonth = DateTime(now.year, now.month, 0).day;
      days += daysInPrevMonth;
    }

    // Logika penyesuaian bulan negatif
    if (months < 0) {
      years--;
      months += 12;
    }

    return {
      'years': years,
      'months': months,
      'days': days,
      'hours': diff.inHours % 24,
      'minutes': diff.inMinutes % 60,
      'seconds': diff.inSeconds % 60,
    };
  }
}
