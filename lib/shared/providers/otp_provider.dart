import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum OtpDestination { VERIFY_EMAIL, RESET_PASS }

class OtpProvider with ChangeNotifier {
  late String _destination;
  void getDestination(OtpDestination intent) {
    switch (intent) {
      case OtpDestination.VERIFY_EMAIL:
        _destination = '/login';
        notifyListeners();
        break;
      case OtpDestination.RESET_PASS:
        _destination = '/resetPass';
        notifyListeners();
      default:
        _destination = '/login';
        break;
    }
  }

  String get destination => _destination;
}
