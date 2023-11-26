import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/shared/models/news_model.dart';
import 'package:app/shared/utils/back_button.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewsDetailsPage extends StatefulWidget {
  const NewsDetailsPage({
    super.key,
    required this.news,
  });
  final Article news;
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
          fontSize: 16,
          height: 1.0,
          color: Colors.white,
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
            ),
          ],
        );
        final TextStyle _contentDetailsStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
              fontFamily: 'Circular',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1.0,
            );
        final TextStyle _contentStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
              fontFamily: 'Circular',
              fontSize: 17,
              height: 1.3,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
            );
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                automaticallyImplyLeading: false,
                leading: backButton(context),
                //
                systemOverlayStyle: SystemUiOverlayStyle.light,
                elevation: 0,
                scrolledUnderElevation: 0,
                collapsedHeight: 160,
                toolbarHeight: 70,
                pinned: true,
                stretch: true,
                backgroundColor: Colors.blue.shade900,
                expandedHeight: 300,
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
                    titlePadding: const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 0),
                    // titlePadding: EdgeInsets.zero,
                    expandedTitleScale: 2,
                    collapseMode: CollapseMode.pin,

                    background: Stack(
                      fit: StackFit.expand,
                      alignment: Alignment.center,
                      children: [
                        (widget.news.urlToImage != null)
                            ? Image.network(
                                widget.news.urlToImage!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/bg/bg.png',
                                fit: BoxFit.cover,
                              ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.75),
                                Colors.black.withOpacity(0.2),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    title: Container(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        widget.news.title,
                        style: _titleStyle,
                        overflow: TextOverflow.fade,
                        maxLines: 5,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                // hasScrollBody: true,
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.news.author!, style: _contentDetailsStyle),
                      Text(DateFormat('yyyy-MM-dd').format(widget.news.publishedAt),
                          style: _contentDetailsStyle.copyWith(fontWeight: FontWeight.w500)),
                      hSpace(20),
                      Text(
                        widget.news.description!,
                        style: _contentStyle,
                        maxLines: 100,
                      ),
                      hSpace(10),
                      Text(
                        widget.news.content,
                        style: _contentStyle,
                        maxLines: 100,
                      ),
                      hSpace(10),
                      const Divider(),
                      hSpace(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Source:',
                            style: _contentDetailsStyle,
                          ),
                          wSpace(5),
                          Text(
                            '${widget.news.source.name}',
                            style: _contentStyle,
                          ),
                        ],
                      ),
                      hSpace(200),
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
