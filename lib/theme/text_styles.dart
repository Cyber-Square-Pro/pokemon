import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle pageTitle = TextStyle(
  color: Colors.white,
  fontFamily: 'Circular',
  letterSpacing: 0,
  fontWeight: FontWeight.bold,
  fontSize: 30.sp,
);
final TextStyle pageTitleWithShadow = TextStyle(
  color: Colors.white,
  fontFamily: 'Circular',
  letterSpacing: 0,
  fontWeight: FontWeight.bold,
  fontSize: 30.sp,
  shadows: [
    BoxShadow(
      blurRadius: 10,
      spreadRadius: 2,
      color: Colors.black.withOpacity(0.4),
    ),
  ],
);

final pageSubtitle = TextStyle(
  color: Colors.white.withOpacity(0.8),
  fontFamily: 'Circular',
  letterSpacing: 0,
  fontSize: 14,
);
