import 'package:app/shared/utils/api_constants.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OtpService {
  final Dio _dio = Dio();
  Dio getDioInstance() {
    return _dio;
  }

  Future<bool> sendOTP(String email) async {
    final uri = '${ApiConstants.baseURL}/users/send-verification-email';
    try {
      final Response response = await _dio.post(uri, data: {'email': email});

      if (response.statusCode == 201) {
        print(response.data);
        return true;
      }
      return false;
    } catch (e) {
      print('Failed to send verification email: $e');
      rethrow;
    }
  }

  Future<bool> verifyEmail(BuildContext context, String email, int otp) async {
    final uri = '${ApiConstants.baseURL}/users/verify-email';

    try {
      final Response response = await _dio.post(uri, data: {
        'email': email,
        'otp': otp,
      });

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.statusCode == 400) {
          // Handle 400 status code (Bad Request)
          return false;
        } else {
          // Handle other DioError cases
          ScaffoldMessenger.of(context).showSnackBar(
            MySnackbars.error('An unexpected error occurred.'),
          );
        }
      } else {
        // Handle other exceptions
        ScaffoldMessenger.of(context).showSnackBar(
          MySnackbars.error('An unexpected error occurred.'),
        );
      }
      return false;
    }
  }

  Future<bool> resetPassword(String email, String password) async {
    try {
      final uri = '${ApiConstants.baseURL}/users/reset-password';
      final Response response = await _dio.patch(uri, data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception(e);
    }
  }
}
