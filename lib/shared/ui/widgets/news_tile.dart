import 'package:app/shared/models/news_model.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';

Widget newsTitle(BuildContext context, News news) {
  const newsTitleStyle = TextStyle(
    fontFamily: 'Circular',
    fontSize: 25,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    height: 1.0,
    color: Colors.white,
  );
  final newsSubTitleStyle = TextStyle(
    fontFamily: 'Circular',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.25,
    height: 1.25,
    color: Colors.white.withOpacity(0.75),
  );
  return Container(
    margin: const EdgeInsets.only(bottom: 5),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.deepPurple,
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withOpacity(0.5),
          blurRadius: 10,
          offset: const Offset(-2, 2),
        ),
      ],
      borderRadius: const BorderRadius.all(Radius.circular(15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          news.title,
          style: newsTitleStyle,
        ),
        hSpace(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'By ${news.author}',
              style: newsSubTitleStyle,
            ),
            Text(
              '${news.date}',
              style: newsSubTitleStyle,
            ),
          ],
        )
      ],
    ),
  );
}
