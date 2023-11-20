import 'package:app/shared/repositories/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  final dio = AuthService().getDioInstance();

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Add access token to the headers
    final accessToken = await getAccessToken();
    options.headers['Authorization'] = 'Bearer $accessToken';
    return handler.next(options);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    // Handle token expiration and regeneration if needed
    if (response.statusCode == 401) {
      // Token expired or invalid, regenerate it
      final refreshed = await regenerateToken();
      if (refreshed) {
        // Retry the original request with the new access token
        final RequestOptions options = response.requestOptions;
        options.headers['Authorization'] = 'Bearer ${await getAccessToken()}';
        return dio.request(options.path, options: options as Options);
      }
    }

    return handler.next(response);
  }
}

Future<String?> getAccessToken() async {
  // Retrieve the access token from a secure storage (e.g., SharedPreferences)
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('accessToken');
}

Future<bool> regenerateToken() async {
  try {
    final authService = AuthService();
    await authService.requestNewAccessToken();
    return true; // Token regenerated successfully
  } catch (error) {
    print('Token regeneration failed: $error');
    return false; // Token regeneration failed
  }
}
