import 'package:app/shared/providers/youtube_provider.dart';
import 'package:app/shared/ui/widgets/animated_pokeball.dart';
import 'package:app/shared/utils/error_card.dart';
import 'package:app/shared/utils/page_transitions.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/video_card.dart';
import 'package:app/theme/app_layout.dart';
import 'package:app/modules/videos/play_video.dart';
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

    if (context.read<YoutubeProvider>().videoList.isEmpty) {
      final key = dotenv.env['YT_API_KEY']!;
      context.read<YoutubeProvider>().fetchVideoList(key);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: AppLayouts.horizontalPagePadding,
      ),
      sliver: SliverList(
        key: const Key('videos_page'),
        delegate: SliverChildListDelegate(
          [
            Consumer<YoutubeProvider>(
              builder: (context, provider, child) {
                if (provider.state == YoutubeSearchState.loading) {
                  return Center(
                    child: Column(
                      children: [
                        AnimatedPokeballWidget(
                          color: Theme.of(context).textTheme.titleSmall!.color!,
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
                      height: 100.h,
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
                  clipBehavior: Clip.none,
                  shrinkWrap: true,
                  itemCount: provider.videoList.length,
                  padding: EdgeInsets.only(bottom: 20.h),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    final video = provider.videoList[index];

                    return VideoCard(
                      videoTitle: video.snippet.title,
                      uploader: video.snippet.channelTitle,
                      index: index,
                      imageurl: video.snippet.thumbnails.medium.url,
                      onTap: () {
                        Navigator.push(
                          context,
                          TransitionPageRoute(
                            duration: const Duration(milliseconds: 600),
                            child: PlayVideo(
                              index: index,
                              id: video.id.videoId,
                              video: video.snippet,
                            ),
                            transition: index % 2 == 0
                                ? PageTransitions.slideRight
                                : PageTransitions.slideLeft,
                            curve: Curves.ease,
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
