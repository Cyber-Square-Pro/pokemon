import 'package:app/shared/models/pokemon_summary.dart';
import 'package:app/shared/utils/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesService {
  final _dio = Dio();
  Dio getDioInstance() => _dio;

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
        options: Options(headers: {'Connection': 'keep-alive'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final String res = response.data;
        return bool.parse(res);
      } else {
        return false;
      }
    } catch (e) {
      print('Error');
      return false;
      // throw Exception(e);
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
        options: Options(headers: {'Connection': 'keep-alive'}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Failed to add favourite');
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
        options: Options(headers: {'Connection': 'keep-alive'}),
      );

      if (response.statusCode == 201) {
        final List<dynamic> result = response.data;
        final List<PokemonSummary> pokemon =
            result.map((item) => PokemonSummary.fromJson(item)).toList();
        return pokemon;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
      // throw Exception(e);
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
    } catch (e) {
      throw Exception(e);
    }
  }
}
