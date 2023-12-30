import 'package:app/shared/models/daily_checkin_model.dart';
import 'package:app/shared/repositories/auth_interceptor.dart';

import 'package:app/shared/repositories/daily_checkin_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CheckinState { init, loading, loaded, error }

class CheckinProvider extends ChangeNotifier {
  CheckinProvider(BuildContext context) {
    _dio = DailyCheckinService.getDio();
    _dio.interceptors.add(
      AuthInterceptor(dio: _dio, context: context),
    );
  }

  late Dio _dio;

  late CheckinState _state = CheckinState.init;
  late DailyCheckinData _dailyCheckinData =
      DailyCheckinData(joinDate: DateTime.now(), history: []);
  late List<History> _checkinHistory = [];
  late bool _checkedInToday = false;

  final _checkinRepository = DailyCheckinService.instance;

  Future<void> checkIn(BuildContext context) async {
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

  Stream<DailyCheckinData> fromHistoryStream(BuildContext context) async* {
    _state = CheckinState.loading;
    notifyListeners();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String username = prefs.getString('username')!;
      await for (final checkinData
          in _checkinRepository.historyStream(username)) {
        yield checkinData;
        if (checkinData.history.isNotEmpty &&
            checkinData.history.last.isCheckedIn == true &&
            checkinData.history.last.createdAt.day == DateTime.now().day) {
          _checkedInToday = true;
        }
        _dailyCheckinData = checkinData;
        _checkinHistory = checkinData.history;
        _state = CheckinState.loaded;
      }

      notifyListeners();
    } on DioException {
      _state = CheckinState.error;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _checkedInToday = false;
    _dailyCheckinData = DailyCheckinData(joinDate: DateTime.now(), history: []);
    _checkinHistory = [];
    _state = CheckinState.init;
    notifyListeners();
    super.dispose();
  }

  DailyCheckinData get data => _dailyCheckinData;
  List<History> get history => _checkinHistory;
  bool get checkedInToday => _checkedInToday;
  CheckinState get state => _state;
}
