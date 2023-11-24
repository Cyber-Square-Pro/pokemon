import 'package:app/shared/utils/api_constants.dart';
import 'package:dio/dio.dart';

class FavouritesService {
  static final dio = Dio();
  Dio getDioInstance() {
    return dio;
  }

  Future<void> getProtectedRoute() async {
    final uri = '${ApiConstants.baseURL}/auth/protected';
    final Response response = await dio.get(uri);

    if (response.statusCode == 200) {
      print('Success: ${response.data}');
    } else {
      print(response.statusCode);
      print(response.data);
      print(response.statusMessage);
    }
  }
}
