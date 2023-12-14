import 'package:app/shared/widgets/%20video_card.dart';
import 'package:app/videos/play_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: true,
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: 2,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15.w),
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            return VideoCard(
              videoTitle: 'Pokemon Adventure',
              subtitle: 'pokemon videos subtitle',
              imageurl: '',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayVideo(index: index),
                  ),
                );
              },
              index: index,
            );
          }),
    );
  }
}
