import 'package:animations/animations.dart';
import 'package:app/modules/news/news_details_page.dart';
import 'package:app/shared/models/news_model.dart';
import 'package:app/shared/repositories/auth_interceptor.dart';
import 'package:app/shared/repositories/news_service.dart';
import 'package:app/shared/ui/widgets/news_tile.dart';
import 'package:app/shared/utils/error_card.dart';
import 'package:app/shared/widgets/loading_spinner.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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
  late Dio dio = newsService.getDioInstance();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Fetch the initial page
    dio.interceptors.add(AuthInterceptor(dio: dio, context: context));
    _fetchPage(1);
  }

  final NewsService newsService = NewsService();
  final PagingController<int, News> _pagingController = PagingController(firstPageKey: 1);

  @override
  Widget build(BuildContext context) {
    // UI
    return SliverFillRemaining(
      key: const Key('news_page'),
      hasScrollBody: true,
      fillOverscroll: true,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent &&
              !_isLoading &&
              _pagingController.nextPageKey != null) {
            _fetchPage(_pagingController.nextPageKey as int);
            _isLoading = true;
          }
          return false;
        },
        child: PagedListView(
          pagingController: _pagingController,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
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
              child: Padding(
                padding: EdgeInsets.only(top: 200.h),
                child: loadingSpinner(context),
              ),
            ),
            newPageProgressIndicatorBuilder: (context) => Column(
              children: [
                Center(child: loadingSpinner(context, EdgeInsets.symmetric(vertical: 30.h))),
              ],
            ),
            noMoreItemsIndicatorBuilder: (context) => Center(
              child: errorCard(context, 'Notice', 'You have reached the end'),
            ),
            noItemsFoundIndicatorBuilder: (context) => Column(
              children: [
                Center(
                  child: errorCard(context, 'Notice', 'No news available'),
                ),
              ],
            ),
            firstPageErrorIndicatorBuilder: (context) => Center(
              child: Column(
                children: [
                  errorCard(
                    context,
                    'Error!',
                    'Unable to fetch news',
                    Colors.red,
                    75,
                    ElevatedButton.icon(
                      onPressed: () {
                        _fetchPage(1);
                      },
                      icon: const Icon(CupertinoIcons.repeat),
                      label: const Text('Retry'),
                    ),
                  ),
                ],
              ),
            ),
            animateTransitions: true,
          ),
        ),
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<News> newsList = await newsService.fetchAllArticles(pageKey);
      if (newsList.isEmpty) {
        // If the fetched newsList is empty, consider it as the last page
        _pagingController.appendLastPage([]);
      } else {
        // Append the fetched newsList and increment the page key
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newsList, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    } finally {
      _isLoading = false;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    dio.interceptors.clear();
    super.dispose();
  }
}
