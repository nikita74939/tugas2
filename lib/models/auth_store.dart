class UserModel {
  final String username;
  final String password;
  final String name;

  const UserModel({
    required this.username,
    required this.password,
    required this.name,
  });
}

class AuthStore {
  // Menggunakan private constructor untuk singleton
  AuthStore._();
  static final AuthStore instance = AuthStore._();

  // Langsung masukkan akun admin ke dalam list saat inisialisasi
  final List<UserModel> _users = [
    const UserModel(username: 'admin', password: '1234', name: 'Administrator'),
  ];

  UserModel? login(String username, String password) {
    try {
      return _users.firstWhere(
        (u) => u.username == username && u.password == password,
      );
    } catch (_) {
      return null;
    }
  }

  bool register(String username, String password, String name) {
    final exists = _users.any((u) => u.username == username);
    if (exists) return false;
    _users.add(UserModel(username: username, password: password, name: name));
    return true;
  }

  bool get hasUsers => _users.isNotEmpty;
}
