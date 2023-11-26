import 'package:app/shared/models/news_model.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget newsTitle(BuildContext context, Article article, void Function() onTap) {
  const double tileHeight = 160;
  final newsTitleStyle = TextStyle(
    fontFamily: 'Circular',
    fontSize: 25,
    fontWeight: FontWeight.bold,
    letterSpacing: -1,
    height: 1.0,
    color: Colors.white,
    shadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.4),
        blurRadius: 25,
      ),
    ],
  );
  final newsSubTitleStyle = TextStyle(
    fontFamily: 'Circular',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.25,
    height: 1.25,
    color: Colors.white.withOpacity(0.9),
    shadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.4),
        blurRadius: 25,
      ),
    ],
  );
  return Padding(
    padding: const EdgeInsets.only(bottom: 5, top: 5),
    child: InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Ink(
            height: tileHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(
              //     color: tileColor.withOpacity(0.5),
              //     blurRadius: 7,
              //     // offset: const Offset(-2, 2),
              //   )
              // ],
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: (article.urlToImage != null)
                    ? Image.network(article.urlToImage!).image
                    : const AssetImage('assets/images/bg/bg.png'),
              ),
            ),
          ),
          Container(
            height: tileHeight,
            key: const Key('cont'),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0.1, 0.8],
                colors: [Colors.black.withOpacity(0.8), Colors.black.withOpacity(0.1)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  // direction: Axis.horizontal,
                  // mainAxisSize: MainAxisSize.min,
                  // clipBehavior: Clip.none,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(AppTheme.globalBorderRadius),
                      ),
                      width: 150,
                      child: Text(
                        'By ${article.author}',
                        style: newsSubTitleStyle,
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(AppTheme.globalBorderRadius),
                      ),
                      child: Text(
                        DateFormat('yyyy-MM-dd').format(article.publishedAt),
                        style: newsSubTitleStyle,
                      ),
                    ),
                  ],
                ),
                hSpace(10),
                Text(
                  article.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: newsTitleStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
