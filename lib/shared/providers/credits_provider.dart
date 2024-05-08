import 'package:app/shared/repositories/auth_interceptor.dart';
import 'package:app/shared/repositories/credits_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CreditState { init, loading, loaded, error }

class CreditsProvider extends ChangeNotifier {
  CreditsProvider(BuildContext context) {
    _dio = CreditService.instance.getDio();
    _dio.interceptors.add(AuthInterceptor(dio: _dio, context: context));
  }
  late Dio _dio;

  late CreditState _state = CreditState.init;
  late double _credits = 0.00;

  Future<void> getCredits() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String username = prefs.getString('username')!;
      _credits = await CreditService.instance.getCredits(username);
      notifyListeners();
    } catch (e) {
      _credits = 0.0;
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
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String username = prefs.getString('username')!;
      await CreditService.instance.addCredit(username, amount);
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

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String username = prefs.getString('username')!;
      await CreditService.instance.spendCredit(username, amount);
      _state = CreditState.loaded;
      notifyListeners();
    } catch (e) {
      _state = CreditState.error;
      notifyListeners();
      throw Exception(e);
    }
  }

  Stream<double> fromCreditStream(BuildContext context) async* {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String username = prefs.getString('username')!;

      await for (double data in CreditService.instance.creditStream(username)) {
        yield data;
        _credits = data;
      }
      notifyListeners();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        yield 0.0;
      } else if (e.response?.statusCode == 500) {
        yield 0.0;
      }
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
