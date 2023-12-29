import 'dart:convert';
import 'package:app/shared/utils/api_constants.dart';
import 'package:dio/dio.dart';

class CreditService {
  CreditService._();

  static final CreditService _instance = CreditService._();
  static CreditService get instance => _instance;

  static final Dio _dio = Dio();

  Dio getDio() => _dio;

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

  Stream<double> creditStream(String username) async* {
    try {
      final Response response = await _dio.post(
        '${ApiConstants.baseURL}/credits',
        data: {'username': username},
        options: Options(persistentConnection: true),
      );
      if (response.statusCode == 201) {
        final Map<String, dynamic> result = jsonDecode(
          jsonEncode(response.data),
        );
        yield double.parse(result['credits'].toString());
      }
    } on DioException catch (e) {
      print(e);
      yield 0.0;
    }
  }

  Future<double> getCredits(String username) async {
    final String uri = '${ApiConstants.baseURL}/credits/';
    final Response response = await _dio.post(
      uri,
      data: {
        'username': username,
      },
    );
    final Map<String, dynamic> result = jsonDecode(
      jsonEncode(response.data),
    );
    return double.parse(result['credits'].toString());
  }
}
