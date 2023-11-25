import 'package:app/shared/models/news_model.dart';
import 'package:app/shared/repositories/auth_interceptor.dart';
import 'package:app/shared/repositories/news_service.dart';
import 'package:app/shared/ui/widgets/news_tile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _dio = newsService.getDioInstance();
    _dio.interceptors.add(AuthInterceptor(dio: _dio));
  }

  final NewsService newsService = NewsService();
  late Dio _dio;
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      fillOverscroll: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            // News listview builder
            FutureBuilder(
              future: NewsService().fetchAllArticles(),
              builder: (BuildContext context, snapshot) {
                print(snapshot.data);
                if (snapshot.hasData) {
                  final newsList = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: newsList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        News news = newsList[index];
                        return newsTitle(context, news);
                      },
                      // separatorBuilder: (context, index) => const Divider(),
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: const CircularProgressIndicator(),
                  );
                } else {
                  return const Center(child: Text('Error'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
