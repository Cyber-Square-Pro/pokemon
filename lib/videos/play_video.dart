import 'package:app/shared/repositories/auth_interceptor.dart';
import 'package:app/shared/repositories/favourites_service.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideo extends StatefulWidget {
  const PlayVideo({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayVideo> createState() => _VideosPageState();
}

class _VideosPageState extends State<PlayVideo> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'rg6CiPI6h2g&pp=ygUScG9rZW1vbiB2aWRlbyBzb25n',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
      );
    
    // TODO: implement initState
    
  }

  @override
  Widget build(BuildContext context) {
    return  SliverFillRemaining(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
