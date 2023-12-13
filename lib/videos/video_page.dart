import 'package:app/shared/widgets/%20video_card.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      fillOverscroll: false,
      child: GridView.builder(
      shrinkWrap: true,
        itemCount: 2,
        padding: EdgeInsets.zero,
       
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.25
          ), 
        itemBuilder:  (context, index){
          return VideoCard(
            videoTitle: 'Pokemon Adventure', 
            imageurl: '', 
            subtitle: '', 
            onTap: () {  },
            

          );
        }
        ),
    );
  }
}