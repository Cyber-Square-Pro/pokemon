import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/shared/models/youtube_search_result_model.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/theme/app_theme.dart';
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
                      toolbarHeight: 45.h,
                      title: Padding(
                        padding: EdgeInsets.only(right: 15.w),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            'Now Playing:  ${widget.video.title}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              overflow: TextOverflow.fade,
                            ),
                          ),
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
                      flex: _controller.value.isFullScreen ? 1 : 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              !_controller.value.isFullScreen ? 10.w : 0,
                        ),
                        child: Hero(
                          tag: '${widget.index}',
                          child: GestureDetector(
                            onVerticalDragDown: (details) {
                              if (details.localPosition >
                                  details.globalPosition) {
                                if (_controller.value.isFullScreen) {
                                  _controller.toggleFullScreenMode();
                                }
                              }
                            },
                            child: ClipRRect(
                              clipBehavior: _controller.value.isFullScreen
                                  ? Clip.none
                                  : Clip.antiAlias,
                              borderRadius: BorderRadius.circular(15),
                              child: YoutubePlayer(
                                controller: _controller,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    hSpace(10),

                    if (orientation == Orientation.portrait)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Container(
                              padding: EdgeInsets.all(12.5.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppTheme.globalBorderRadius),
                                color: mediumBlue.withOpacity(0.25),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    widget.video.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.video.channelTitle,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: 0,
                                            ),
                                      ),
                                      Text(
                                        DateFormat('dd-MM-yyyy')
                                            .format(widget.video.publishedAt),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: 0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Description
                            hSpace(10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                widget.video.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 0,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .color!,
                                    ),
                                maxLines: 10,
                              ),
                            ),
                            // Additional info
                          ],
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
