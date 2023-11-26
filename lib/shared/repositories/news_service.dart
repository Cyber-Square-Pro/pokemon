import 'package:app/shared/models/news_model.dart';
import 'package:app/shared/utils/api_constants.dart';
import 'package:dio/dio.dart';

class NewsService {
  static final dio = Dio();
  Dio getDioInstance() {
    return dio;
  }

  Future<List<Article>> fetchAllArticles() async {
    try {
      Response response = await dio.get(
        'https://newsapi.org/v2/everything?q=pokemon&apiKey=bb642f547ad8439b8d04342f644d7597',
      );

      if (response.statusCode == 200) {
        // Assuming the JSON array is the top-level structure

        // Use map to convert each item in the list
        final News result = News.fromJson(response.data);
        // print(result.articles);
        return result.articles;
      } else {
        return [];
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
