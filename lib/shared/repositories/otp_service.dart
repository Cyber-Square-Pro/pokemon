import 'package:app/shared/utils/api_constants.dart';
import 'package:dio/dio.dart';

class OtpService {
  final Dio _dio = Dio();
  Dio getDioInstance() {
    return _dio;
  }

  Future<void> sendOTP(String email) async {
    final uri = '${ApiConstants.baseURL}/users/send-verification-email';
    try {
      final Response response = await _dio.post(uri, data: {'email': email});
      print(response.data);
    } catch (e) {
      print('Failed to send verification email: $e');
      rethrow;
    }
  }

  Future<bool> verifyEmail(String email, int otp) async {
    final uri = '${ApiConstants.baseURL}/users/verify-email';
    try {
      final Response response = await _dio.post(uri, data: {
        'email': email,
        'otp': otp,
      });
      print(response.data);
      return bool.parse(response.data);
    } catch (e) {
      throw Exception('Failed $e');
    }
  }
}
