import 'package:flutter/material.dart';

class SignupProvider with ChangeNotifier {
  Map<String, dynamic> _signupData = {};

  late bool _emailVerified;

  void setSignupData(Map<String, dynamic> data) {
    _signupData = data;
    notifyListeners();
  }

  void clearSignupData() {
    _signupData.clear();
    notifyListeners();
  }

  void setEmailToVerified() {
    _emailVerified = true;
    notifyListeners();
  }

  Map<String, dynamic> get getSignupData => _signupData;
  bool get isEmailVerified => _emailVerified;
}
