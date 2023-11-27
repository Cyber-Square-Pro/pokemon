// import 'package:animations/animations.dart';
// import 'package:app/modules/news/news_details_page.dart';
// import 'package:app/shared/models/news_model.dart';
// import 'package:app/shared/repositories/auth_interceptor.dart';
// import 'package:app/shared/repositories/news_service.dart';
// import 'package:app/shared/ui/widgets/news_tile.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// class NewsPage extends StatefulWidget {
//   const NewsPage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<NewsPage> createState() => _NewsPageState();
// }

// class _NewsPageState extends State<NewsPage> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     _dio = newsService.getDioInstance();
//     _dio.interceptors.add(AuthInterceptor(dio: _dio));
//   }

//   final NewsService newsService = NewsService();
//   late Dio _dio;
//   @override
//   Widget build(BuildContext context) {
//     return SliverFillRemaining(
//       hasScrollBody: true,
//       fillOverscroll: true,
//       child: Column(
//         children: [
//           // News listview builder
//           FutureBuilder(
//             future: NewsService().fetchAllArticles(),
//             builder: (BuildContext context, snapshot) {
//               print(snapshot.data);
//               if (snapshot.hasData) {
//                 final newsList = snapshot.data!;
//                 return ListView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: newsList.length,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     Article article = newsList[index];
//                     return OpenContainer(
//                       transitionDuration: const Duration(milliseconds: 400),
//                       closedColor: Colors.transparent,
//                       openColor: Colors.transparent,
//                       clipBehavior: Clip.none,
//                       openElevation: 0,
//                       closedElevation: 0,
//                       openBuilder: (context, VoidCallback open) => NewsDetailsPage(news: article),
//                       closedBuilder: (context, VoidCallback open) => Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: newsTitle(
//                           context,
//                           article,
//                           () {
//                             print('clicked');
//                             open();
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                   // separatorBuilder: (context, index) => const Divider(),
//                 );
//               } else if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else {
//                 return const Center(child: Text('Error'));
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:animations/animations.dart';
import 'package:app/modules/news/news_details_page.dart';
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
  late Dio _dio;

  @override
  void initState() {
    super.initState();
    _dio = newsService.getDioInstance();
    _dio.interceptors.add(AuthInterceptor(dio: _dio));
    newsService.fetchAllArticles();
  }

  final NewsService newsService = NewsService();

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return FutureBuilder(
            future: NewsService().fetchAllArticles(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                final List<News> newsList = snapshot.data!;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: newsList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    News news = newsList[index];
                    return OpenContainer(
                      transitionDuration: const Duration(milliseconds: 500),
                      closedColor: Colors.transparent,
                      openColor: Colors.transparent,
                      clipBehavior: Clip.none,
                      openElevation: 0,
                      closedElevation: 0,
                      openBuilder: (context, VoidCallback open) => NewsDetailsPage(news: news),
                      closedBuilder: (context, VoidCallback open) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: newsTitle(
                          context,
                          news,
                          () {
                            print('clicked');
                            open();
                          },
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(child: Text('Error'));
              }
            },
          );
        },
        childCount: 1,
      ),
    );
  }
}
