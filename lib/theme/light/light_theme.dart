import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamilyFallback: const ['Circular'],
  fontFamily: 'Circular',
  appBarTheme: const AppBarTheme(
    foregroundColor: Color(0xFF303943),
    backgroundColor: Colors.white,
    titleSpacing: 0,
    titleTextStyle: TextStyle(
      fontFamily: 'Circular',
      fontSize: 21,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
      height: 0,
      color: Color(0xFF303943),
    ),
  ),
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
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 0,
      letterSpacing: 0,
      color: Color(0xFFA4A4A4),
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 0,
      letterSpacing: 0,
      color: Color(0xFF303943),
    ),
    //
    // bodyText1: const TextStyle(
    //   fontFamily: "CircularStd-Book",
    //   fontSize: 14,
    //   fontWeight: FontWeight.normal,
    //   color: Color(0xFF303943),
    // ),
    // bodyText2: const TextStyle(
    //   fontFamily: "CircularStd-Book",
    //   fontSize: 14,
    //   fontWeight: FontWeight.normal,
    // ),
    // subtitle1: const TextStyle(
    //   fontFamily: "CircularStd-Book",
    //   fontSize: 14,
    //   fontWeight: FontWeight.normal,
    //   color: Color(0xFFA4A4A4),
    // ),
    // headline1: const TextStyle(
    //   fontFamily: "CircularStd-Book",
    //   fontSize: 30,
    //   fontWeight: FontWeight.bold,
    //   color: Color(0xFF303943),
    // ),
    // headline2: const TextStyle(
    //   fontFamily: "CircularStd-Book",
    //   fontSize: 30,
    //   fontWeight: FontWeight.bold,
    //   color: Color(0xFF303943),
    // ),
    // headline3: const TextStyle(
    //   fontFamily: "CircularStd-Book",
    //   fontSize: 26,
    //   fontWeight: FontWeight.bold,
    //   color: Color(0xFF303943),
    // ),
    // headline4: const TextStyle(
    //   fontFamily: "CircularStd-Book",
    //   fontSize: 22,
    //   fontWeight: FontWeight.bold,
    //   color: Color(0xFF303943),
    // ),
    // headline5: const TextStyle(
    //   fontFamily: "CircularStd-Book",
    //   fontSize: 18,
    //   fontWeight: FontWeight.bold,
    //   color: Color(0xFF303943),
    // ),
    // headline6: const TextStyle(
    //   fontFamily: "CircularStd-Book",
    //   fontSize: 14,
    //   fontWeight: FontWeight.bold,
    //   color: Color(0xFF303943),
    // ),
  ),
);
