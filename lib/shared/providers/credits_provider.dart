import 'package:app/shared/repositories/auth_interceptor.dart';
import 'package:app/shared/repositories/credits_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CreditState { init, loading, loaded, error }

class CreditsProvider extends ChangeNotifier {
  late CreditState _state = CreditState.init;
  late double _credits = 0.00;

  final CreditService _creditService = CreditService.instance;

  Future<void> getCreditCount(BuildContext context) async {
    _state = CreditState.loading;
    notifyListeners();
    final dio = _creditService.getDioInstance();
    dio.interceptors.add(AuthInterceptor(dio: dio, context: context));
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String username = prefs.getString('username')!;
      final result = await _creditService.getCreditCount(username);
      _credits = result;
      _state = CreditState.loaded;
      notifyListeners();
    } catch (e) {
      _state = CreditState.error;
      notifyListeners();
      throw Exception(e);
    }
  }

  Future<void> addCredits(
    BuildContext context, [
    double amount = 25,
  ]) async {
    _state = CreditState.loading;
    notifyListeners();
    final dio = _creditService.getDioInstance();
    dio.interceptors.add(AuthInterceptor(dio: dio, context: context));
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String username = prefs.getString('username')!;
      await _creditService.addCredit(username, amount);
      _state = CreditState.loaded;
      notifyListeners();
    } catch (e) {
      _state = CreditState.error;
      notifyListeners();
      throw Exception(e);
    }
  }

  Future<void> spendCredits(
    BuildContext context,
    double amount,
  ) async {
    _state = CreditState.loading;
    notifyListeners();
    final dio = _creditService.getDioInstance();
    dio.interceptors.add(AuthInterceptor(dio: dio, context: context));
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String username = prefs.getString('username')!;
      await _creditService.spendCredit(username, amount);
      _state = CreditState.loaded;
      notifyListeners();
    } catch (e) {
      _state = CreditState.error;
      notifyListeners();
      throw Exception(e);
    }
  }

  void resetCredits() {
    _state = CreditState.error;
    _credits = 0.0;
    notifyListeners();
  }

  CreditState get state => _state;
  double get credits => _credits;
}
