import 'package:app/shared/models/pokemon.dart';
import 'package:app/shared/utils/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class PokemonService extends ChangeNotifier {
  final _dio = Dio();
  Dio getDioInstance() => _dio;

  Future<bool> isFavourite(String username, String favourite) async {
    final uri = '${ApiConstants.baseURL}/favourites/contains';
    try {
      final Response response = await _dio.post(uri, data: {
        'user': username,
        'favourite': favourite,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error');
      throw Exception(e);
    }
  }

  Future<bool> addFavourite(String username, String favourite) async {
    final uri = '${ApiConstants.baseURL}/favourites/add';
    try {
      final Response response = await _dio.post(uri, data: {
        'user': username,
        'favourite': favourite,
      });

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Failed to add favourite');
      throw Exception(e);
    }
  }

  Future<bool> getFavourites(String username, String favourite) async {
    final uri = '${ApiConstants.baseURL}/favourites/add';
    try {
      final Response response = await _dio.post(uri, data: {
        'user': username,
        'favourite': favourite,
      });

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Failed to add favourite');
      throw Exception(e);
    }
  }

  Future<List<Pokemon>> getAllFavourites(List<String> favourites) async {
    final List<Pokemon> pokeList = [];
    try {
      for (final String id in favourites) {
        final Response response = await _dio.get(ApiConstants.pokemonDetails(id));
        if (response.statusCode == 200) {
          final Pokemon pokemon = Pokemon.fromJson(response.data);
          pokeList.add(pokemon);
        }
      }
      return pokeList;
    } catch (error) {
      print(error);
      return [];
    }
  }
}
