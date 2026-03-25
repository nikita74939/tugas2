import 'package:flutter/material.dart';

class AgeController {
  // Tambahkan parameter 'int second' agar input dari user terbaca
  Map<String, int> calculateAge(DateTime date, TimeOfDay time, int second) {
    // 1. Gabungkan tanggal, jam, DAN detik lahir secara spesifik
    DateTime birth = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
      second, // <--- Sekarang detiknya pakai input user
    );
    DateTime now = DateTime.now();

    // 2. Hitung selisih Kalender (Tahun, Bulan, Hari)
    int years = now.year - birth.year;
    int months = now.month - birth.month;
    int days = now.day - birth.day;

    // Logika penyesuaian jika hari lahir lebih besar dari hari sekarang
    if (days < 0) {
      months--;
      // Mengambil jumlah hari di bulan sebelumnya
      int daysInPrevMonth = DateTime(now.year, now.month, 0).day;
      days += daysInPrevMonth;
    }

    // Logika penyesuaian jika bulan lahir lebih besar dari bulan sekarang
    if (months < 0) {
      years--;
      months += 12;
    }

    // 3. Hitung selisih Waktu (Jam, Menit, Detik) secara presisi
    // Duration menghitung total selisih waktu secara nyata
    Duration diff = now.difference(birth);

    // Gunakan modulo (%) untuk memecah total durasi ke format jam digital
    int hours = diff.inHours % 24;
    int minutes = diff.inMinutes % 60;
    int seconds = diff.inSeconds % 60;

    // 4. Return hasil dalam bentuk Map
    return {
      'years': years,
      'months': months,
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
    };
  }
}
