import 'package:app/shared/models/news_model.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget newsTitle(BuildContext context, News news, void Function() onTap) {
  const Color tileColor = Colors.indigo;
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
    color: Colors.white.withOpacity(0.75),
    shadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.4),
        blurRadius: 5,
      ),
    ],
  );
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: tileColor.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(-2, 2),
                )
              ],
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bg/bg.png'),
              ),
            ),
          ),
          Container(
            height: 120,
            key: const Key('cont'),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: const [0.1, 0.9],
                colors: [tileColor.withOpacity(0.8), tileColor.withOpacity(0)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  news.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
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
                      DateFormat('yyyy-MM-dd').format(news.date),
                      style: newsSubTitleStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
