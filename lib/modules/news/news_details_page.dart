import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/shared/models/news_model.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewsDetailsPage extends StatefulWidget {
  const NewsDetailsPage({
    super.key,
    required this.news,
  });
  final News news;
  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(builder: (context) {
        final TextStyle _titleStyle = Theme.of(context).textTheme.headline1!.copyWith(
              fontFamily: 'Circular',
              fontSize: 15,
              height: 1.0,
              color: Colors.white,
            );
        final TextStyle _contentDetailsStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
              fontFamily: 'Circular',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1.0,
            );
        final TextStyle _contentStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
              fontFamily: 'Circular',
              fontSize: 16,
              height: 1.3,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
            );
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                systemOverlayStyle: SystemUiOverlayStyle.light,
                foregroundColor: Colors.white,
                elevation: 0,
                scrolledUnderElevation: 0,
                collapsedHeight: 140,
                toolbarHeight: 60,
                pinned: true,
                stretch: true,
                backgroundColor: Colors.blue.shade800,
                expandedHeight: 275,
                titleSpacing: 0,
                // title: Text(
                //   widget.news.title,
                //   // style: _titleStyle,
                //   overflow: TextOverflow.fade,
                // ),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    expandedTitleScale: 2,
                    collapseMode: CollapseMode.parallax,
                    background: Image.asset(
                      'assets/images/bg/bg.png',
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      widget.news.title,
                      style: _titleStyle,
                      overflow: TextOverflow.fade,
                      maxLines: 4,
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.news.author, style: _contentDetailsStyle),
                          Text(DateFormat('yyyy-MM-dd').format(widget.news.date),
                              style: _contentDetailsStyle),
                        ],
                      ),
                      hSpace(10),
                      Text(
                        widget.news.content,
                        style: _contentStyle,
                      ),
                      hSpace(10),
                      const Divider(),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
