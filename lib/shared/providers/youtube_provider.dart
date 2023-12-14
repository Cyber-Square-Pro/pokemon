import 'package:app/shared/models/youtube_search_result_model.dart';
import 'package:app/shared/repositories/youtube_service.dart';
import 'package:flutter/material.dart';

class YoutubeProvider extends ChangeNotifier {
  late List<VideoItem> _searchResults = [];

  Future<void> fetchVideoList(String key) async {
    final dataProvider = YoutubeService();
    final YoutubeSearchResult data = await dataProvider.getVideoList(key);
    _searchResults = data.items;
    notifyListeners();
  }

  List<VideoItem> get videoList => _searchResults;

  @override
  void dispose() {
    super.dispose();
  }
}
