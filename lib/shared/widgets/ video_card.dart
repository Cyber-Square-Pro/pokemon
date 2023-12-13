import 'package:app/shared/utils/spacer.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({
    super.key,
    required this.videoTitle,
    required this.subtitle,
    required this.imageurl, 
    required this.onTap,
    required this.index,
   });
   final void Function() onTap;
    final String videoTitle;
    final String subtitle;
    final String imageurl;
    final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppTheme.getColors(context).panelBackground
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.w),
        child: Column(
          children: [
            Hero(
              tag: '$index',
              child: Image.network(imageurl, width: double.infinity, height: 100.h, fit: BoxFit.cover,)),
            hSpace(10),
            Text(
              videoTitle,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize:15.sp,
                fontWeight: FontWeight.bold
              )
            ),
            hSpace(10),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.75),
                fontSize: 13.sp,
                
            )
              ),
          ],
        ),
      ),
    );
  }
}