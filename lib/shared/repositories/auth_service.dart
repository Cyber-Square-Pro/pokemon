import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String baseURL = 'https://10db-2405-201-f00c-3016-2849-cb0e-f79f-f609.ngrok-free.app';

class AuthService {
  static final dio = Dio();
  Dio getDioInstance() {
    return dio;
  }

  Future<void> apiTest() async {
    final response = await dio.get(baseURL);
    print(response.data);
  }

  Future<void> login(String email, String password) async {
    try {
      Response response = await dio.post(
        '$baseURL/auth/login',
        data: {'email': email, 'password': password},
      );

      final accessToken = response.data['accessToken'];
      final refreshToken = response.data['refreshToken'];

      print('AccessToken: $accessToken');
      print('RefreshToken: $refreshToken');

      // Save tokens to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('accessToken', accessToken);
      prefs.setString('refreshToken', refreshToken);
    } catch (error) {
      print('Authentication failed');
      rethrow;
    }
  }

  Future<void> requestNewAccessToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refreshToken');

      Response response = await dio.post(
        '$baseURL/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );

      final newAccessToken = response.data['accessToken'];

      // Update the access token in SharedPreferences
      prefs.setString('accessToken', newAccessToken);
    } catch (error) {
      print('Access token could not be re-generated $error');
      rethrow;
    }
  }

  Future<void> regenerateToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refreshToken');

      if (refreshToken != null) {
        await requestNewAccessToken();

        print('Token regenerated successfully');
      } else {
        // Handle the case where refreshToken is null (user is not logged in or no refresh token available)
        print('No refresh token available. User needs to log in.');
      }
    } catch (error) {
      // Handle error during token regeneration
      print('Token regeneration failed: $error');
      rethrow;
    }
  }
}
