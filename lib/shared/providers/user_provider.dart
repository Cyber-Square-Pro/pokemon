import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late String _username = '';

  set setUsername(String name) {
    _username = name;
    notifyListeners();
  }

  void clearUsername() {
    _username = '';
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _username = '';
  }

  String get username => _username;
}
