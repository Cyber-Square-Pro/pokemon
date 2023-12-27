import 'package:app/shared/models/daily_checkin_model.dart';
import 'package:app/shared/repositories/auth_interceptor.dart';

import 'package:app/shared/repositories/daily_checkin_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CheckinState { init, loading, loaded, error }

class CheckinProvider extends ChangeNotifier {
  late CheckinState _state = CheckinState.init;
  late DailyCheckinData _dailyCheckinData;
  late List<History> _checkinHistory = [];
  late bool _checkedInToday = false;

  final _checkinRepository = DailyCheckinService.instance;

  Future<void> checkIn(BuildContext context) async {
    _checkinRepository.getDioInstance().interceptors.add(
          AuthInterceptor(
            dio: _checkinRepository.getDioInstance(),
            context: context,
          ),
        );
    _state = CheckinState.loading;
    notifyListeners();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String username = prefs.getString('username')!;
      await _checkinRepository.checkIn(username);
      context.mounted ? await getHistory(context) : null;
      _state = CheckinState.loaded;
      notifyListeners();
    } on DioException catch (e) {
      _state = CheckinState.error;
      notifyListeners();
      print(e.message);
    }
  }

  Future<void> getHistory(BuildContext context) async {
    _checkinRepository.getDioInstance().interceptors.add(
          AuthInterceptor(
            dio: _checkinRepository.getDioInstance(),
            context: context,
          ),
        );
    _state = CheckinState.loading;
    notifyListeners();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String username = prefs.getString('username')!;
      DailyCheckinData result = await _checkinRepository.getHistory(username);

      if (result.history.isNotEmpty &&
          result.history.last.isCheckedIn == true &&
          result.history.last.createdAt.day == DateTime.now().day) {
        _checkedInToday = true;
      }
      _dailyCheckinData = result;
      _checkinHistory = result.history;
      _state = CheckinState.loaded;
      notifyListeners();
    } on DioException catch (e) {
      print(e.message);
      _state = CheckinState.error;
      notifyListeners();
    }
  }

  void clearCheckinProvider() {
    _checkedInToday = false;
    _checkinHistory = [];
    _state = CheckinState.init;
    notifyListeners();
  }

  DailyCheckinData get data => _dailyCheckinData;
  List<History> get history => _checkinHistory;
  bool get checkedInToday => _checkedInToday;
  CheckinState get state => _state;
}