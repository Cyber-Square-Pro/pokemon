import 'dart:convert';

import 'package:app/shared/providers/youtube_provider.dart';
import 'package:app/shared/ui/widgets/animated_pokeball.dart';
import 'package:app/shared/utils/error_card.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/%20video_card.dart';
import 'package:app/theme/app_theme.dart';
import 'package:app/videos/play_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  void initState() {
    super.initState();

    final key = dotenv.env['YT_API_KEY']!;
    context.read<YoutubeProvider>().fetchVideoList(key);
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: AppTheme.homePadding.horizontal - 5,
      ),
      sliver: SliverList(
        key: const Key('videos_page'),
        delegate: SliverChildListDelegate(
          [
            Consumer<YoutubeProvider>(
              builder: (context, provider, child) {
                if (provider.state == YoutubeSearchState.LOADING) {
                  return Center(
                    child: Column(
                      children: [
                        AnimatedPokeballWidget(
                          color: Theme.of(context).textTheme.bodyText1!.color!,
                          size: 40.h,
                        ),
                        hSpace(10),
                        const Text('Loading Videos'),
                      ],
                    ),
                  );
                }

                if (provider.videoList.isEmpty) {
                  return Center(
                    child: SizedBox(
                      height: 75.h,
                      child: errorCard(
                        context,
                        'Notice',
                        'No Videos available',
                        Colors.grey.shade800,
                      ),
                    ),
                  );
                }
                // If Videos List is not empty
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: provider.videoList.length,
                  padding: EdgeInsets.only(bottom: 20.h),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final video = provider.videoList[index];

                    return VideoCard(
                      videoTitle: video.snippet.title,
                      description: video.snippet.description,
                      index: index,
                      imageurl: video.snippet.thumbnails.medium.url,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayVideo(
                              index: index,
                              video: video.snippet,
                              id: video.id.videoId,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
