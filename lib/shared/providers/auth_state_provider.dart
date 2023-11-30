import 'package:app/shared/widgets/loading_spinner_modal.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _authenticated = false;

  bool get isAuthenticated => _authenticated;

  logout(context) async {
    setAuthenticated(false);
    showLoadingSpinnerModal(context, 'Logging out');
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    prefs.remove('accessToken');
    prefs.remove('refreshToken');
    prefs.remove('$username-favourites-pokemons');
    prefs.remove('username');
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/login');
  }

  void setAuthenticated(bool value) {
    _authenticated = value;
    notifyListeners();
  }
}
