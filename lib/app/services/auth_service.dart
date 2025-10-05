import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  String? _currentUser;

  bool get isLoggedIn => _currentUser != null;
  String? get currentUser => _currentUser;

  static const _usersKey = 'registered_users';
  static const _loggedInUserKey = 'logged_in_user_email';

  AuthService() {
    // Tidak perlu memanggil _loadCurrentUser di sini lagi, akan dipanggil secara eksplisit dari SplashScreen
  }

  // Metode untuk memuat pengguna yang sedang login dari SharedPreferences
  // Dibuat public agar bisa dipanggil dari SplashScreen
  Future<void> loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    _currentUser = prefs.getString(_loggedInUserKey);
    // print('AuthService: Loaded user: $_currentUser'); // Debugging: Anda bisa mengaktifkan ini untuk melihat output di konsol
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersString = prefs.getString(_usersKey) ?? '[]';
    final List<dynamic> users = jsonDecode(usersString);

    final user = users.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => null,
    );

    if (user != null) {
      _currentUser = user['email'];
      await prefs.setString(_loggedInUserKey, email); // Simpan email pengguna yang login
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    
    final usersString = prefs.getString(_usersKey) ?? '[]';
    final List<dynamic> users = jsonDecode(usersString);

    final exists = users.any((u) => u['email'] == email);
    if (exists) {
      return false;
    }

    users.add({'email': email, 'password': password});

    await prefs.setString(_usersKey, jsonEncode(users));

    // Setelah register berhasil, secara otomatis login dan simpan sesi
    _currentUser = email;
    await prefs.setString(_loggedInUserKey, email); // Simpan email pengguna yang login
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    _currentUser = null;
    await prefs.remove(_loggedInUserKey); // Hapus email pengguna yang login
    notifyListeners();
  }
}
