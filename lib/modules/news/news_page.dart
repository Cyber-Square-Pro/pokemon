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
import 'package:app/shared/utils/error_card.dart';
import 'package:app/shared/widgets/loading_spinner.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
    newsService.fetchAllArticles(1);
  }

  final NewsService newsService = NewsService();
  final PagingController<int, News> _pagingController = PagingController(firstPageKey: 1);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: PagedListView(
        pagingController: _pagingController,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (BuildContext context, News news, int index) {
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
                child: newsTitle(context, news: news, onTap: () {
                  // Function to open and read each news article
                  open();
                  /*  Function to mark this news item as 'read' 
                  when the user clicks on it*/
                }),
              ),
            );
          },
          firstPageProgressIndicatorBuilder: (context) => Center(
            child: Column(children: [loadingSpinner(context)]),
          ),
          newPageProgressIndicatorBuilder: (context) =>
              Center(child: loadingSpinner(context, EdgeInsets.symmetric(vertical: 20.h))),
          noMoreItemsIndicatorBuilder: (context) => Center(
            child: errorCard(context, 'Ran out of news'),
          ),
          noItemsFoundIndicatorBuilder: (context) => Center(
            child: errorCard(context, 'No news available'),
          ),
          animateTransitions: true,
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<News> newsList = await newsService.fetchAllArticles(pageKey);
      final isLastPage = newsList.isEmpty;
      if (isLastPage) {
        _pagingController.appendLastPage(newsList);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newsList, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
