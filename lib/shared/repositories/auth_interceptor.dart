import 'package:app/shared/providers/auth_state_provider.dart';
import 'package:app/shared/repositories/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.dio,
    required this.context,
  });
  final Dio dio;
  final BuildContext context;

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? apikey = dotenv.env['API_KEY'];

    print('Requesting with accessToken in header');
    final accessToken = await getAccessToken();
    options.headers['Authorization'] = 'Bearer $accessToken';
    options.headers['api-key'] = '$apikey';

    return handler.next(options);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
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
          );
          final Options opts = Options(
            method: options.method,
            headers: options.headers,
            contentType: options.contentType,
          );
          retryOptions.headers['Authorization'] =
              'Bearer ${await getAccessToken()}';
          print('retried ${options.path} with new access token');
          return await dio.request(retryOptions.path, options: opts);
        } catch (retryError) {
          context.mounted ? logout(context) : null;
          return handler.reject(retryError as DioException);
        }
      }
    }

    return handler.next(err);
  }

  void logout(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).logout(context);
  }
}

Future<String?> getAccessToken() async {
  // Retrieve the access token from a secure storage (e.g., SharedPreferences)
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('accessToken');
}

Future<bool> regenerateToken() async {
  print('Regenerating access token...');
  try {
    AuthService.instance.requestNewAccessToken();
    print('Token re-generated succesfully');
    return true; // Token regenerated successfully
  } catch (error) {
    print('Token regeneration failed: $error');
    return false; // Token regeneration failed
  }
}
