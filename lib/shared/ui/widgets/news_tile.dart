import 'package:app/shared/models/news_model.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

Widget newsTitle(BuildContext context, {required News news, required void Function() onTap}) {
  final double tileHeight = 160.h;
  final newsTitleStyle = TextStyle(
    fontFamily: 'Circular',
    fontSize: 25.sp,
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
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: InkWell(
      borderRadius: BorderRadius.circular(AppTheme.globalBorderRadius),
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Ink(
            height: tileHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.globalBorderRadius),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: (news.urlToImage != null)
                    ? Image.network(news.urlToImage!).image
                    : const AssetImage('assets/images/bg/bg.png'),
              ),
            ),
          ),
          Container(
            height: tileHeight,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(AppTheme.globalBorderRadius),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0.1, 0.8],
                colors: [Colors.black.withOpacity(0.7), Colors.black.withOpacity(0.25)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(AppTheme.globalBorderRadius),
                  ),
                  child: Text(
                    DateFormat('yyyy-MM-dd').format(news.publishedAt),
                    style: newsSubTitleStyle,
                  ),
                ),
                hSpace(10),
                Text(
                  news.title,
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
