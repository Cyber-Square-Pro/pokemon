import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/shared/models/youtube_search_result_model.dart';
import 'package:app/shared/ui/widgets/animated_pokeball.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideo extends StatefulWidget {
  const PlayVideo({
    required this.index,
    required this.video,
    super.key,
    required this.id,
  });

  final int index;
  final String id;
  final Snippet video;
  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late YoutubePlayerController _controller;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(
        // forceHD: true,
        autoPlay: true,
        controlsVisibleAtStart: true,
        mute: false,
      ),
    );
  }

  late bool canPop = true;

  @override
  void initState() {
    super.initState();
    canPop = true;
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(builder: (context) {
        return PopScope(
          canPop: !_controller.value.isFullScreen,
          onPopInvoked: (didPop) {
            if (_controller.value.isFullScreen) {
              _controller.toggleFullScreenMode();
            }
          },
          child: OrientationBuilder(
            builder: (context, orientation) => Scaffold(
              appBar: (orientation == Orientation.landscape)
                  ? null
                  : AppBar(
                      titleSpacing: 0,
                      toolbarHeight: 50.h,
                      title: Text(
                        widget.video.title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
              backgroundColor: Theme.of(context).colorScheme.background,
              body: SafeArea(
                top: orientation == Orientation.landscape ? false : true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Youtube Player
                    Expanded(
                      flex: 2,
                      child: Hero(
                        tag: '${widget.index}',
                        child: GestureDetector(
                          onVerticalDragDown: (details) {
                            if (details.localPosition > details.globalPosition) {
                              if (_controller.value.isFullScreen) {
                                _controller.toggleFullScreenMode();
                              }
                            }
                          },
                          child: YoutubePlayer(
                            controller: _controller,
                            actionsPadding: const EdgeInsets.symmetric(vertical: 5),
                          ),
                        ),
                      ),
                    ),
                    hSpace(10),

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
                                widget.video.title,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0,
                                      height: 1.1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                maxLines: 3,
                              ),
                              hSpace(5),
                              // Uploader and date
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.video.channelTitle,
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0,
                                        ),
                                  ),
                                  Text(
                                    DateFormat('dd-MM-yyyy').format(widget.video.publishedAt),
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0,
                                        ),
                                  ),
                                ],
                              ),
                              // Description
                              const Divider(),
                              Text(
                                widget.video.description,
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
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
