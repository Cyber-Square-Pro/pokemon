import 'package:app/shared/models/daily_checkin_model.dart';
import 'package:app/shared/repositories/auth_interceptor.dart';
import 'package:app/shared/repositories/daily_checkin_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckinProvider extends ChangeNotifier {
  late DailyCheckinData _dailyCheckins;
  late List<History> _checkinHistory = [];
  late bool _checkedInToday = false;

  final _repository = DailyCheckinService.instance;

  Future<void> checkIn(BuildContext context) async {
    _repository.getDioInstance().interceptors.add(
          AuthInterceptor(
            dio: _repository.getDioInstance(),
            context: context,
          ),
        );

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String username = prefs.getString('username')!;
      await _repository.checkIn(username);
      context.mounted ? await getHistory(context) : () {};
      notifyListeners();
    } on DioException catch (e) {
      print(e.message);
    } catch (e) {
      return;
    }
  }

  Future<void> getHistory(BuildContext context) async {
    _repository.getDioInstance().interceptors.add(
          AuthInterceptor(
            dio: _repository.getDioInstance(),
            context: context,
          ),
        );
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String username = prefs.getString('username')!;
      final DailyCheckinData result = await _repository.getHistory(username);

      print(result.history);
      if (result.history.last.isCheckedIn == true &&
          result.history.last.createdAt.day == DateTime.now().day) {
        _checkedInToday = true;
      }
      _dailyCheckins = result;
      _checkinHistory = result.history;
      notifyListeners();
    } on DioException catch (e) {
      print(e.message);
    } catch (e) {
      return;
    }
  }

  @override
  void dispose() {
    _checkedInToday = false;
    _checkinHistory = [];
    super.dispose();
  }

  DailyCheckinData get data => _dailyCheckins;
  List<History> get history => _checkinHistory;
  bool get checkedInToday => _checkedInToday;
}
