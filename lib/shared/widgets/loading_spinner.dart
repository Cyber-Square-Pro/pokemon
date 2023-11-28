import 'package:app/shared/ui/widgets/animated_pokeball.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget loadingSpinner(BuildContext context, [EdgeInsetsGeometry? padding, String? message]) {
  return Padding(
    padding: padding ?? EdgeInsets.zero,
    child: Flex(
      direction: Axis.vertical,
      children: [
        AnimatedPokeballWidget(
          color: Theme.of(context).textTheme.bodyText1!.color!,
          size: 35.h,
        ),
        hSpace(5),
        Text(
          message ?? 'Loading...',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    ),
  );
}
