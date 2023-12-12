import 'dart:convert';

import 'package:app/shared/models/news_model.dart';
import 'package:app/shared/utils/api_constants.dart';
import 'package:dio/dio.dart';

class NewsService {
  static final _dio = Dio();

  Dio getDioInstance() => _dio;

  Future<List<News>> fetchAllArticles(int page, {int pageSize = 10}) async {
    Response response = await _dio.get(
      '${ApiConstants.baseURL}/news?page=$page&pageSize=$pageSize',
      options: Options(headers: {'Connection': 'keep-alive'}),
    );

    if (response.statusCode == 200) {
      await Future.delayed(const Duration(milliseconds: 200));
      final List<dynamic> responseData = response.data;
      final List<News> result = newsFromJson(json.encode(responseData));

      return result;
    } else {
      print('Failed to fetch articles. Status code: ${response.statusCode}');
      return [];
    }
  }
}
