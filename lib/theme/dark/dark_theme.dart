import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    foregroundColor: Colors.white,
    backgroundColor: const Color(0xFF121212),
    titleSpacing: 0,
    titleTextStyle: TextStyle(
      fontFamily: 'Circular',
      fontSize: 21.sp,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
      height: 0,
    ),
  ),
  //
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.focused)) {
          return Colors.white;
        } else if (states.contains(MaterialState.error)) {
          return Colors.red;
        }
        return Colors.white.withOpacity(0.5);
      },
    ),
    suffixIconColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.focused)) {
          return Colors.white;
        } else if (states.contains(MaterialState.error)) {
          return Colors.red;
        }
        return Colors.white.withOpacity(0.5);
      },
    ),
  ),
  fontFamilyFallback: const ['Circular'],
  fontFamily: 'Circular',
  brightness: Brightness.dark,

  scaffoldBackgroundColor: const Color(0xFF121212),
  textTheme: TextTheme(
    // Body
    bodySmall: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFA4A4A4),
      height: 0,
      letterSpacing: 0,
    ),
    titleSmall: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFE0E0E0),
      height: 0,
      letterSpacing: 0,
    ),
  ),
);
