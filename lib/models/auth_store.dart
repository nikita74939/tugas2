// Model data user — menyimpan kredensial dan nama tampilan
class UserModel {
  final String username;
  final String password; // Disimpan plaintext — hanya untuk keperluan demo/tugas
  final String name;

  const UserModel({
    required this.username,
    required this.password,
    required this.name,
  });
}

// Penyimpanan user in-memory dengan pola singleton — data hilang saat app ditutup
class AuthStore {
  // Singleton: pastikan hanya ada satu instance AuthStore di seluruh app
  AuthStore._();
  static final AuthStore instance = AuthStore._();

  // Akun admin di-hardcode sebagai data awal untuk kemudahan testing
  final List<UserModel> _users = [
    const UserModel(username: 'admin', password: '1234', name: 'Administrator'),
  ];

  // Kembalikan UserModel jika cocok, null jika username/password salah
  UserModel? login(String username, String password) {
    try {
      return _users.firstWhere(
        (u) => u.username == username && u.password == password,
      );
    } catch (_) {
      // firstWhere melempar StateError jika tidak ditemukan — tangkap dan return null
      return null;
    }
  }

  // Daftarkan user baru — return false jika username sudah dipakai
  bool register(String username, String password, String name) {
    final exists = _users.any((u) => u.username == username);
    if (exists) return false;
    _users.add(UserModel(username: username, password: password, name: name));
    return true;
  }

  bool get hasUsers => _users.isNotEmpty;
}