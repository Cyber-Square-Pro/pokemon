import 'dart:convert';

import 'package:app/shared/utils/api_constants.dart';
import 'package:dio/dio.dart';

class CreditService {
  CreditService._();

  static final CreditService _instance = CreditService._();
  static CreditService get instance => _instance;

  final Dio _dio = Dio();
  Dio getDioInstance() => _dio;

  Future<double> getCreditCount(String username) async {
    final String uri = '${ApiConstants.baseURL}/credits';
    final Response response =
        await _dio.post(uri, data: {'username': username});
    if (response.statusCode == 201) {
      final Map<String, dynamic> result = jsonDecode(jsonEncode(response.data));
      print(result);
      return double.parse(result['credits'].toString());
    }
    return 0.0;
  }

  Future<void> addCredit(String username, double amount) async {
    final String uri = '${ApiConstants.baseURL}/credits/add';
    await _dio.patch(uri, data: {
      'username': username,
      'amount': amount,
    });
  }

  Future<void> spendCredit(String username, double amount) async {
    final String uri = '${ApiConstants.baseURL}/credits/spend';
    await _dio.patch(uri, data: {
      'username': username,
      'amount': amount,
    });
  }
}
