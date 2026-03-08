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

/// Simple in-memory user store — tidak perlu database
class AuthStore {
  AuthStore._();
  static final AuthStore instance = AuthStore._();

  final List<UserModel> _users = [];

  /// Login: return user jika cocok, null jika gagal
  UserModel? login(String username, String password) {
    try {
      return _users.firstWhere(
        (u) => u.username == username && u.password == password,
      );
    } catch (_) {
      return null;
    }
  }

  /// Register: return false jika username sudah ada
  bool register(String username, String password, String name) {
    final exists = _users.any((u) => u.username == username);
    if (exists) return false;
    _users.add(UserModel(username: username, password: password, name: name));
    return true;
  }

  bool get hasUsers => _users.isNotEmpty;
}