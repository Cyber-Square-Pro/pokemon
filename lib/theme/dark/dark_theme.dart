import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.light,
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
  fontFamilyFallback: const ['Circular'],
  fontFamily: 'Circular',
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF121212),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontFamily: "CircularStd-Book",
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Color(0xFFE0E0E0),
    ),
    bodyText2: TextStyle(
      fontFamily: "CircularStd-Book",
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    subtitle1: TextStyle(
      fontFamily: "CircularStd-Book",
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Color(0xFFA4A4A4),
    ),
    headline1: TextStyle(
      fontFamily: "CircularStd-Book",
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Color(0xFFE0E0E0),
    ),
    headline2: TextStyle(
      fontFamily: "CircularStd-Book",
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Color(0xFFE0E0E0),
    ),
    headline3: TextStyle(
      fontFamily: "CircularStd-Book",
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: Color(0xFFE0E0E0),
    ),
    headline4: TextStyle(
      fontFamily: "CircularStd-Book",
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Color(0xFFE0E0E0),
    ),
    headline5: TextStyle(
      fontFamily: "CircularStd-Book",
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color(0xFFE0E0E0),
    ),
    headline6: TextStyle(
      fontFamily: "CircularStd-Book",
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Color(0xFFE0E0E0),
    ),
  ),
);
