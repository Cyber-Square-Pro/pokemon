import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
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
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 0,
      letterSpacing: 0,
      color: Color.fromARGB(255, 155, 155, 155),
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 0,
      letterSpacing: 0,
      color: Color.fromARGB(255, 41, 49, 58),
    ),
  ),

  //
  colorScheme: ColorScheme.light(
    primary: Colors.blue.shade700,
    onPrimary: Colors.white,
    // Tertiary
    tertiary: const Color.fromARGB(255, 122, 134, 159),
    onTertiary: const Color.fromARGB(255, 49, 52, 59),
  ),
);
