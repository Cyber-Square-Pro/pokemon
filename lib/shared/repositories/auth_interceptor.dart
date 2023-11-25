import 'package:app/shared/repositories/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.dio,
  });
  final Dio dio;

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print('Interceptor onRequest called');
    final accessToken = await getAccessToken();
    options.headers['Authorization'] = 'Bearer $accessToken';
    return handler.next(options);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print('Interceptor onError() called with error: $err');
    if (err.response?.statusCode == 401) {
      print('Access Token expired');
      final refreshed = await regenerateToken();
      if (refreshed) {
        // Retry the original request with the new access token
        try {
          final RequestOptions options = err.requestOptions;
          final RequestOptions retryOptions = RequestOptions(
            method: options.method,
            headers: options.headers,
            contentType: options.contentType,
            path: options.path,
            // Add other necessary properties
          );
          final Options opts = Options(
            method: options.method,
            headers: options.headers,
            contentType: options.contentType,
          );
          retryOptions.headers['Authorization'] = 'Bearer ${await getAccessToken()}';
          return await dio.request(retryOptions.path, options: opts);
        } catch (retryError) {
          print('Retry error occured');
          return handler.reject(retryError as DioException); // Propagate the retry error
        }
      }
    }

    return handler.next(err);
  }

  // @override
  // Future onResponse(Response response, ResponseInterceptorHandler handler) async {
  //   print('Interceptor onResponse() called');
  //   if (response.statusCode == 200) {
  //     print('Re-call successful');
  //   }
  // }
}

Future<String?> getAccessToken() async {
  // Retrieve the access token from a secure storage (e.g., SharedPreferences)
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('accessToken');
}

Future<bool> regenerateToken() async {
  print('regenerate token called');
  try {
    final authService = AuthService();
    await authService.requestNewAccessToken();
    return true; // Token regenerated successfully
  } catch (error) {
    print('Token regeneration failed: $error');
    return false; // Token regeneration failed
  }
}
