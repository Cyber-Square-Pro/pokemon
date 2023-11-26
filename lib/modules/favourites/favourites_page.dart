import 'package:app/shared/repositories/auth_interceptor.dart';
import 'package:app/shared/repositories/favourites_service.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _dio = favService.getDioInstance();
    _dio.interceptors.add(AuthInterceptor(dio: _dio));
  }

  final FavouritesService favService = FavouritesService();
  late Dio _dio;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        children: [
          Center(
            child: ElevatedButton(
              child: const Text('Call Protected Route'),
              onPressed: () async {
                try {
                  await favService.getProtectedRoute();
                  ScaffoldMessenger.of(context).showSnackBar(
                    MySnackbars.success('Success!'),
                  );
                } catch (e) {
                  throw Exception(e);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
