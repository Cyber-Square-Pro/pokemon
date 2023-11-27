import 'dart:convert';

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
        final List<dynamic> responseData = response.data;
        final List<News> result = newsFromJson(json.encode(responseData));
        print(result);
        return result;
      } else {
        print('Failed to fetch articles. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching articles: $error');
      throw Exception(error);
    }
  }
}
