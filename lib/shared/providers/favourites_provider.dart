import 'package:app/shared/models/pokemon_summary.dart';
import 'package:app/shared/repositories/auth_interceptor.dart';
import 'package:app/shared/repositories/favourites_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

enum FavouritesState { INIT, LOADING, LOADED, ERROR }

class FavouritesProvider extends ChangeNotifier {
  late bool _isFav = false;
  late List<PokemonSummary> _favourites = [];
  late FavouritesState _state = FavouritesState.INIT;

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
    changeState(FavouritesState.LOADING);
    dio.interceptors.add(AuthInterceptor(dio: dio, context: context));
    final bool result = await favService.addFavourite(favourite);
    _isFav = result;
    notifyListeners();
    changeState(FavouritesState.LOADED);
    dio.interceptors.clear();
    return result;
  }

  Future<bool> removeFavourite(
    BuildContext context,
    String favourite,
  ) async {
    final Dio dio = favService.getDioInstance();
    changeState(FavouritesState.LOADING);

    dio.interceptors.add(AuthInterceptor(dio: dio, context: context));
    final bool result = await favService.removeFavourite(favourite);
    _isFav = !result;
    _favourites.removeWhere((element) => element.number == favourite);

    changeState(FavouritesState.LOADED);
    notifyListeners();
    dio.interceptors.clear();
    return result;
  }

  Future<List<PokemonSummary>> fetchFavourites(BuildContext context) async {
    final Dio dio = favService.getDioInstance();
    changeState(FavouritesState.LOADING);
    dio.interceptors.add(AuthInterceptor(dio: dio, context: context));
    try {
      final List<PokemonSummary> result = await favService.getFavourites();
      _favourites = result;
      dio.interceptors.clear();
      changeState(FavouritesState.LOADED);
      notifyListeners();
      return _favourites;
    } catch (e) {
      changeState(FavouritesState.ERROR);
      notifyListeners();
      return [];
    }
  }

  void clearFavourites() {
    _favourites.clear();
    changeState(FavouritesState.INIT);
    changeState(FavouritesState.LOADING);
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
