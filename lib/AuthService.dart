import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  String? _user;
  final String _hardcodedUsername = 'user';
  final String _hardcodedPassword = 'password';

  bool get isAuthenticated => _user != null;

  String? get user => _user;

  void login(String username, String password) {
    if (username == _hardcodedUsername && password == _hardcodedPassword) {
      _user = username;
      notifyListeners(); // Notify listeners to update UI based on login status
    } else {
      throw Exception('Invalid credentials');
    }
  }

  void logout() {
    _user = null;
    notifyListeners(); // Notify listeners to update UI based on logout status
  }
}
