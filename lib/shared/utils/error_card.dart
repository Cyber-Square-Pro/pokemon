import 'package:app/shared/utils/app_constants.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget errorCard(BuildContext context, String title, String message,
    [Color color = Colors.red, double size = 75, Widget? child]) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppConstants.ashShockedImage,
              height: size,
              width: size,
              fit: BoxFit.fitHeight,
            ),
            wSpace(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Circular',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.25,
                    color: Colors.white,
                    height: 0,
                  ),
                ),
                Text(
                  message,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: 'Circular',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.25,
                    color: Colors.white.withOpacity(0.75),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                child ?? const SizedBox(),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
