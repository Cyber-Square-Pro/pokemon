import 'package:app/shared/repositories/auth_interceptor.dart';
import 'package:app/shared/repositories/favourites_service.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:app/theme/app_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideo extends StatefulWidget {
  const PlayVideo({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;
  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'rg6CiPI6h2g',
      flags: YoutubePlayerFlags(
        controlsVisibleAtStart: true,
        autoPlay: true,
        mute: false,
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_controller.value.isFullScreen) {
      _controller.toggleFullScreenMode(); // Exit fullscreen
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return OrientationBuilder(
      builder: (context, orientation) => Scaffold(
        appBar: (orientation == Orientation.landscape)
            ? null
            : AppBar(
                title: Text('Video title'),
              ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          top: orientation == Orientation.landscape ? false : true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              // Youtube Player
              Expanded(
                flex: 2,
                child: Hero(
                  tag: '${widget.index}',
                  child: YoutubePlayer(
                    actionsPadding: const EdgeInsets.symmetric(vertical: 5),
                    controller: _controller,
                    progressIndicatorColor: Colors.red.shade600,
                    showVideoProgressIndicator: true,
                  ),
                ),
              ),

              if (orientation == Orientation.portrait)
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 10.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          'Video title',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0,
                                overflow: TextOverflow.ellipsis,
                              ),
                          maxLines: 2,
                        ),
                        // Uploader and date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Video Uploader',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0,
                                  ),
                            ),
                            Text(
                              'Publish Date',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0,
                                  ),
                            ),
                          ],
                        ),
                        // Description
                        Text(
                          'Video description',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                                letterSpacing: 0,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5),
                              ),
                          maxLines: 10,
                        ),
                        // Additional info
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
