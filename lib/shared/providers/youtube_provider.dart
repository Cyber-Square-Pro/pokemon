import 'package:app/shared/models/youtube_search_result_model.dart';
import 'package:app/shared/repositories/youtube_service.dart';
import 'package:flutter/material.dart';

enum YoutubeSearchState { INIT, LOADING, LOADED, ERROR }

class YoutubeProvider with ChangeNotifier {
  late YoutubeSearchState _state = YoutubeSearchState.INIT;

  late List<VideoItem> _searchResults = [];

  void changeState(YoutubeSearchState newState) async {
    _state = newState;
  }

  Future<void> fetchVideoList(String apiKey) async {
    final dataProvider = YoutubeService.getInstance();
    changeState(YoutubeSearchState.LOADING);

    try {
      final YoutubeSearchResult data = await dataProvider.getVideoList(apiKey);

      _searchResults = data.items;
      changeState(YoutubeSearchState.LOADED);
      notifyListeners();
    } catch (e) {
      changeState(YoutubeSearchState.ERROR);
    }
  }

  @override
  void dispose() {
    changeState(YoutubeSearchState.INIT);
    super.dispose();
  }

  List<VideoItem> get videoList => _searchResults;
  YoutubeSearchState get state => _state;
}
