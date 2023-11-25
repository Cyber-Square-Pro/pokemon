import 'package:app/shared/models/news_model.dart';
import 'package:app/shared/utils/api_constants.dart';
import 'package:dio/dio.dart';

class NewsService {
  static final dio = Dio();
  Dio getDioInstance() {
    return dio;
  }

  Future<List<News>> fetchAllArticles() async {
    try {
      Response response = await dio.get(
        '${ApiConstants.baseURL}/news',
      );

      if (response.statusCode == 200) {
        print(response.data);

        // Assuming the JSON array is the top-level structure
        final List<dynamic> responseData = response.data;

        // Use map to convert each item in the list
        final List<News> result = responseData.map((json) => News.fromJson(json)).toList();

        return result;
      } else {
        return [];
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
