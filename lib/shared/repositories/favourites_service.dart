import 'package:app/shared/models/pokemon_summary.dart';
import 'package:app/shared/utils/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesService {
  FavouritesService._();
  static final _instance = FavouritesService._();
  static FavouritesService get instance => _instance;

  final _dio = Dio();
  Dio getDio() => _dio;

  Future<bool> isFavourite(String favourite) async {
    final uri = '${ApiConstants.baseURL}/favourites/contains';
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String username = prefs.getString('username')!;

      final Response response = await _dio.post(
        uri,
        data: {
          'username': username,
          'favourite': favourite,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addFavourite(String favourite) async {
    final uri = '${ApiConstants.baseURL}/favourites/add';
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String username = prefs.getString('username')!;

      final Response response = await _dio.patch(
        uri,
        data: {
          'username': username,
          'favourite': favourite,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print(e);
      // throw Exception(e);
      return false;
    }
  }

  Future<List<PokemonSummary>> getFavourites() async {
    final uri = '${ApiConstants.baseURL}/favourites/';
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String username = prefs.getString('username')!;
      final Response response = await _dio.post(
        uri,
        data: {'username': username},
      );

      if (response.statusCode == 201) {
        final List<dynamic> result = response.data;
        final List<PokemonSummary> pokemon =
            result.map((item) => PokemonSummary.fromJson(item)).toList();
        return pokemon;
      } else {
        return [];
      }
    } on DioException catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> removeFavourite(String number) async {
    final uri = '${ApiConstants.baseURL}/favourites/remove';
    try {
      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('username');
      final Response response = await _dio.delete(
        uri,
        data: {
          'username': username,
          'favourite': number,
        },
        options: Options(headers: {'Connection': 'keep-alive'}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioException catch (e) {
      print(e);
      return false;
    }
  }
}
