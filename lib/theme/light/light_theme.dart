import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Circular',
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
  ),
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontFamily: "CircularStd-Book",
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Color(0xFF303943),
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
      color: Color(0xFF303943),
    ),
    headline2: TextStyle(
      fontFamily: "CircularStd-Book",
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Color(0xFF303943),
    ),
    headline3: TextStyle(
      fontFamily: "CircularStd-Book",
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: Color(0xFF303943),
    ),
    headline4: TextStyle(
      fontFamily: "CircularStd-Book",
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Color(0xFF303943),
    ),
    headline5: TextStyle(
      fontFamily: "CircularStd-Book",
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color(0xFF303943),
    ),
    headline6: TextStyle(
      fontFamily: "CircularStd-Book",
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Color(0xFF303943),
    ),
  ),
);
