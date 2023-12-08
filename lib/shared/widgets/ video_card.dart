import 'package:app/shared/utils/spacer.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({
    super.key,
    required this.videoTitle,
    required this.subtitle,
    required this.imageurl, required this.onTap
   });
   final void Function() onTap;
    final String videoTitle;
    final String subtitle;
    final String imageurl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Column(
          children: [
            Image.asset(imageurl, width: double.infinity, height: 200, fit: BoxFit.cover,),
            hSpace(20),
            Text(
              videoTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            hSpace(20),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
              ),
              ),
          ],
        ),
      ),
    );
  }
}