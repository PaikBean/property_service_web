import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final success = await _authService.login(email, password);

    _isLoading = false;
    notifyListeners();

    return success;
  }
}
