import 'package:dio/dio.dart';

final dio = Dio();
const String apiHome = 'http://localhost:3000';
const String loginEndpoint = '$apiHome/auth/login';
const String signupEndpoint = '$apiHome/users/';

class UserRepo {
  Future<void> dioTest() async {
    final response = await dio.get('localhost:3000');
    print(response.data);
  }

  Future<bool> userLogin(String email, String password) async {
    try {
      final response = await dio.post(loginEndpoint, data: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
    return false;
  }

  Future<bool> userSignup({
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final response = await dio.post(loginEndpoint, queryParameters: {
        'username': email,
        'email': email,
        'phone': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
    return false;
  }

  // Future<bool> sendVerificationMail(String email){

  // }
}
