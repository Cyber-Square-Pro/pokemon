import 'package:app/shared/models/pokemon_summary.dart';
import 'package:app/shared/repositories/auth_interceptor.dart';
import 'package:app/shared/repositories/favourites_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class FavouritesProvider extends ChangeNotifier {
  late bool _isFav = false;
  late int _favouritesCount = 0;
  late List<PokemonSummary> _favourites = [];

  FavouritesService favService = FavouritesService();

  Future<void> isAlreadyFavourite(
    BuildContext context,
    String favourite,
  ) async {
    final Dio dio = favService.getDioInstance();
    dio.interceptors.add(AuthInterceptor(dio: dio, context: context));
    final bool result = await favService.isFavourite(favourite);
    _isFav = result;
    notifyListeners();
  }

  Future<bool> addFavourite(
    BuildContext context,
    String favourite,
  ) async {
    final Dio dio = favService.getDioInstance();
    dio.interceptors.add(AuthInterceptor(dio: dio, context: context));
    final bool result = await favService.addFavourite(favourite);
    _isFav = result;
    notifyListeners();
    return result;
  }

  Future<bool> removeFavourite(
    BuildContext context,
    String favourite,
  ) async {
    final Dio dio = favService.getDioInstance();
    dio.interceptors.add(AuthInterceptor(dio: dio, context: context));
    final bool result = await favService.removeFavourite(favourite);
    _isFav = !result;
    _favourites.removeWhere((element) => element.number == favourite);
    notifyListeners();
    return result;
  }

  void getFavourites(BuildContext context) async {
    final Dio dio = favService.getDioInstance();
    dio.interceptors.add(AuthInterceptor(dio: dio, context: context));
    final List<PokemonSummary> result = await favService.getFavourites();
    _favourites = result;
    _favouritesCount = result.length;
    notifyListeners();
  }

  List<PokemonSummary> get favourites => _favourites;
  int get favouritesCount => _favouritesCount;
  bool get isFavourite => _isFav;
}
