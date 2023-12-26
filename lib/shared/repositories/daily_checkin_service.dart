import 'dart:convert';

import 'package:app/shared/models/daily_checkin_model.dart';
import 'package:app/shared/utils/api_constants.dart';
import 'package:dio/dio.dart';

class DailyCheckinService {
  DailyCheckinService._private();

  static final DailyCheckinService _instance = DailyCheckinService._private();
  static DailyCheckinService get instance => _instance;

  // Dio
  static final _dio = Dio();
  Dio getDioInstance() => _dio;

  Future<void> checkIn(String username) async {
    final String uri = '${ApiConstants.baseURL}/daily-checkin/check-in';

    await _dio.patch(uri, data: {'username': username});
  }

  Future<DailyCheckinData> getHistory(String username) async {
    final String uri = '${ApiConstants.baseURL}/daily-checkin/history';

    final Response response =
        await _dio.post(uri, data: {'username': username});

    if (response.statusCode == 201) {
      return dailyCheckinDataFromJson(jsonEncode(response.data));
    }
    return DailyCheckinData(joinDate: DateTime.now(), history: []);
  }
}
