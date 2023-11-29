import 'package:app/shared/repositories/auth_interceptor.dart';
import 'package:app/shared/repositories/favourites_service.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late Dio dio;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final FavouritesService favService = FavouritesService();

  @override
  Widget build(BuildContext context) {
    final dio = favService.getDioInstance();
    dio.interceptors.add(AuthInterceptor(dio: dio, context: context));
    // UI
    return SliverFillRemaining(
      child: Column(
        children: [
          Center(
            child: ElevatedButton(
              child: const Text('Call Protected Route'),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                final username = prefs.getString('username')!;

                if (await favService.getFavourites(username)) {}
              },
            ),
          ),
        ],
      ),
    );
  }
}
