import 'package:flutter/material.dart';

class ObscureProvider with ChangeNotifier {
  late bool _obscurePassword = true;
  late bool _obscureSignupPassword = true;
  late bool _obscureSignupConfirmPassword = true;
  late bool _obscureResetPassword = true;
  late bool _obscureResetConfirmPassword = true;

  void toggleLoginPasswordHidden() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleSignupPasswordHidden() {
    _obscureSignupPassword = !_obscureSignupPassword;
    notifyListeners();
  }

  void toggleSignupPasswordConfirmHidden() {
    _obscureSignupConfirmPassword = !_obscureSignupConfirmPassword;
    notifyListeners();
  }

  void toggleResetPasswordHidden() {
    _obscureResetPassword = !_obscureResetPassword;
    notifyListeners();
  }

  void toggleResetPasswordConfirmHidden() {
    _obscureResetConfirmPassword = !_obscureResetConfirmPassword;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    resetSettings();
  }

  void resetSettings() {
    _obscurePassword = true;
    _obscureResetConfirmPassword = true;
    _obscureResetPassword = true;
    _obscureSignupConfirmPassword = true;
    _obscureSignupPassword = true;
    notifyListeners();
  }

  bool get obscurePassword => _obscurePassword;
  bool get obscureSignupPassword => _obscureSignupPassword;
  bool get obscureSignupConfirmPassword => _obscureSignupConfirmPassword;
  bool get obscureResetPassword => _obscureResetPassword;
  bool get obscureResetConfirmPassword => _obscureResetConfirmPassword;
}
