import 'package:app/shared/models/pokemon_summary.dart';
import 'package:app/shared/repositories/auth_interceptor.dart';
import 'package:app/shared/repositories/favourites_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

enum FavouritesState { init, loading, loaded, error }

class FavouritesProvider extends ChangeNotifier {
  late bool _isFav = false;
  late List<PokemonSummary> _favourites = [];
  late FavouritesState _state = FavouritesState.init;

  FavouritesService favService = FavouritesService();

  void changeState(FavouritesState newState) {
    _state = newState;
    notifyListeners();
  }

  // void checkIfCurrentIsFavourite(BuildContext context, PokemonSummary currentPokemon) async {
  //   final favouritesList = await fetchFavourites(context);
  //   if (favouritesList.contains(currentPokemon)) {
  //     _isFav = true;
  //     notifyListeners();
  //   } else {
  //     _isFav = false;
  //     notifyListeners();
  //   }
  // }

  void checkIfCurrentIsFavourite(
      BuildContext context, PokemonSummary currentPokemon) {
    if (_favourites.contains(currentPokemon)) {
      _isFav = true;
    } else {
      _isFav = false;
    }
    notifyListeners();
  }

  Future<bool> addFavourite(
    BuildContext context,
    String favourite,
  ) async {
    final Dio dio = favService.getDioInstance();
    changeState(FavouritesState.loading);
    dio.interceptors.add(AuthInterceptor(dio: dio, context: context));
    final bool result = await favService.addFavourite(favourite);
    _isFav = result;
    notifyListeners();
    changeState(FavouritesState.loaded);
    dio.interceptors.clear();
    return result;
  }

  Future<bool> removeFavourite(
    BuildContext context,
    String favourite,
  ) async {
    final Dio dio = favService.getDioInstance();
    changeState(FavouritesState.loading);

    dio.interceptors.add(AuthInterceptor(dio: dio, context: context));
    final bool result = await favService.removeFavourite(favourite);
    _isFav = !result;
    _favourites.removeWhere((element) => element.number == favourite);

    changeState(FavouritesState.loaded);
    notifyListeners();
    dio.interceptors.clear();
    return result;
  }

  Future<List<PokemonSummary>> fetchFavourites(BuildContext context) async {
    final Dio dio = favService.getDioInstance();
    changeState(FavouritesState.loading);
    dio.interceptors.add(AuthInterceptor(dio: dio, context: context));
    try {
      final List<PokemonSummary> result = await favService.getFavourites();
      _favourites = result;
      dio.interceptors.clear();
      changeState(FavouritesState.loaded);
      notifyListeners();
      return _favourites;
    } catch (e) {
      changeState(FavouritesState.error);
      notifyListeners();
      return [];
    }
  }

  void clearFavourites() {
    _favourites.clear();
    changeState(FavouritesState.init);
    changeState(FavouritesState.loading);
    notifyListeners();
  }

  List<PokemonSummary> get favourites {
    _favourites
        .sort((a, b) => int.parse(a.number).compareTo(int.parse(b.number)));
    return _favourites;
  }

  FavouritesState get state => _state;
  bool get isFavourite => _isFav;
}
