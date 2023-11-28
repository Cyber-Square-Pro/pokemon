import 'package:app/shared/utils/app_constants.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget errorCard(BuildContext context, String message, [double size = 30]) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppConstants.pikachuSadImage,
          height: size,
          width: size,
          fit: BoxFit.fitHeight,
        ),
        wSpace(10),
        Text(
          message,
          style: TextStyle(
            fontFamily: 'Circular',
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.25,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
      ],
    ),
  );
}
