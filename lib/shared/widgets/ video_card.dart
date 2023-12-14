import 'package:app/shared/utils/spacer.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({
    super.key,
    required this.videoTitle,
    required this.description,
    required this.imageurl,
    required this.onTap,
    required this.index,
  });
  final void Function() onTap;
  final String videoTitle;
  final String description;
  final String imageurl;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppTheme.getColors(context).panelBackground,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: '$index',
                    child: (imageurl == '')
                        ? Container(
                            color: Colors.black,
                            height: 120.h,
                          )
                        : Image.network(
                            imageurl,
                            width: double.infinity,
                            height: 120.h,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const Positioned(
                    bottom: 5,
                    right: 5,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 10.h,
                ),
                child: Column(
                  children: [
                    Text(
                      videoTitle,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            height: 1,
                            letterSpacing: -0.5,
                          ),
                      maxLines: 2,
                    ),
                    hSpace(5),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.75),
                            fontSize: 13.sp,
                            height: 1,
                          ),
                      maxLines: 3,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
