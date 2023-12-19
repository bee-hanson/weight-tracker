import 'package:flutter/material.dart';
import 'package:weight_tracker/services/auth_service.dart';

class LogInViewmodel {
  LogInViewmodel(this._authService);

  final AuthService _authService;

  Future login(String email, String password,
      {required VoidCallback onSuccess}) async {
    try {
      final user = await _authService.login(email, password);
      debugPrint('login successful, ${user.user?.uid}');
      onSuccess();
    } catch (e) {
      // show error message
    }
  }
}
