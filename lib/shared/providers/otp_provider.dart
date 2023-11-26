import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum OtpIntent { SIGN_UP, RESET_PASS, OTHER }

class OtpProvider with ChangeNotifier {
  late String _destination = '';
  late String _email = '';
  late OtpIntent _intent;
  OtpIntent getIntent() {
    return _intent;
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setIntent(OtpIntent intent) {
    print(intent.toString());
    switch (intent) {
      case OtpIntent.SIGN_UP:
        _intent = OtpIntent.SIGN_UP;
        _destination = '/login';
        notifyListeners();
        break;
      case OtpIntent.RESET_PASS:
        _intent = OtpIntent.RESET_PASS;
        _destination = '/resetPass';
        notifyListeners();
      default:
        _destination = '/login';
        break;
    }
  }

  void clearAll() {
    _intent = OtpIntent.OTHER;
    _destination = '';
    _email = '';
  }

  String get destination => _destination;
  String get email => _email;
}
