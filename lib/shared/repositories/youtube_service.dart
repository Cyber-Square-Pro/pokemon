import 'dart:convert';

import 'package:app/shared/models/youtube_search_result_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class YoutubeService {
  final Dio _dio = Dio();

  final String _baseURL = 'https://www.googleapis.com/youtube/v3/search';

  // Fetch list of video search results
  Future<dynamic> getVideoList(String key) async {
    try {
      final Response response = await _dio.get(
        _baseURL,
        queryParameters: {
          'part': 'snippet',
          'chart': 'mostPopular',
          'type': 'video',
          'q': 'Pokemon',
          'key': key,
        },
      );

      if (response.statusCode == 200) {
        final YoutubeSearchResult result = youtubeSearchResultFromJson(
          jsonEncode(response.data),
        );
        return result;
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
