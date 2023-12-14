import 'package:app/shared/models/youtube_search_result_model.dart';
import 'package:app/shared/repositories/youtube_service.dart';
import 'package:flutter/material.dart';

enum YoutubeSearchState { INIT, LOADING, LOADED, ERROR }

class YoutubeProvider extends ChangeNotifier {
  late YoutubeSearchState _state = YoutubeSearchState.INIT;

  late List<VideoItem> _searchResults = [];

  void changeState(YoutubeSearchState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchVideoList(String key) async {
    final dataProvider = YoutubeService();
    changeState(YoutubeSearchState.LOADING);

    try {
      final YoutubeSearchResult data = await dataProvider.getVideoList(key);

      _searchResults = data.items;
      changeState(YoutubeSearchState.LOADED);
      notifyListeners();
    } catch (e) {
      changeState(YoutubeSearchState.ERROR);
    }
  }

  List<VideoItem> get videoList => _searchResults;
  YoutubeSearchState get state => _state;

  @override
  void dispose() {
    _state = YoutubeSearchState.INIT;
    super.dispose();
  }
}
