import 'package:app/shared/utils/spacer.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showNoConnectionDialog(
  final BuildContext context, {
  required String title,
  required String content,
}) async {
  return showDialog(
    useSafeArea: false,
    barrierColor: Colors.black.withOpacity(0.5),
    barrierDismissible: false,
    context: context,
    builder: (context) {
      TextStyle _textTheme = Theme.of(context).textTheme.bodyText1!;
      return AlertDialog(
        surfaceTintColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: EdgeInsets.all(15.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.globalBorderRadius),
            color: Theme.of(context).colorScheme.background,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ^<Lottie/Image>
              wSpace(10),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Altert title
                  Text(
                    title,
                    style: _textTheme.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      letterSpacing: -0.15,
                    ),
                  ),
                  // Altert content
                  Text(
                    content,
                    style: _textTheme.copyWith(
                      color: _textTheme.color!.withOpacity(0.5),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
