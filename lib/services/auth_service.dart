import 'dart:async';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  final List<Map<String, String>> _users = [];
  String? _currentUser;

  bool get isLoggedIn => _currentUser != null;
  String? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = _users.firstWhere(
        (u) => u["email"] == email && u["password"] == password,
      );
      _currentUser = user["email"];
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final exists = _users.any((u) => u["email"] == email);
    if (exists) return false;

    _users.add({"email": email, "password": password});
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
    notifyListeners();
  }
}
