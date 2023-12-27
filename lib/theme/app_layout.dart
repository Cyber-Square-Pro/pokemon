import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLayouts {
  AppLayouts._();

  static double get horizontalPagePadding => 15.sp;
  static double get verticalPagePadding => 10.sp;

  static double get globalBorderRadius => 15.r;

  // Primary color
  static Color getPrimaryColor(BuildContext context) {
    final brightness = Theme.of(context).colorScheme.brightness;
    if (brightness == Brightness.light) {
      return Colors.blue.shade600;
    }
    return Colors.blue.shade800;
  }
}
