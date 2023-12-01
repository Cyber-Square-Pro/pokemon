import 'package:app/shared/widgets/loading_spinner_modal.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _authenticated = false;
  late String _username;

  String get username => _username;
  bool get isAuthenticated => _authenticated;

  getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final String username = prefs.getString('username')!;

    _username = username;
    notifyListeners();
  }

  logout(context) async {
    setAuthenticated(false);
    showLoadingSpinnerModal(context, 'Logging out');
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
    prefs.remove('refreshToken');
    prefs.remove('username');
    prefs.remove('password');
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/login');
  }

  void setAuthenticated(bool value) {
    _authenticated = value;
    notifyListeners();
  }
}
