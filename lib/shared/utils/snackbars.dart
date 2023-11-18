import 'package:flutter/material.dart';

class CustomSnackbars {
  static Duration duration = const Duration(seconds: 2);
  static SnackBar errorSnackbar(String message) => SnackBar(
        duration: duration,
        content: Text(
          message,
          style: _snackbarTextSyle,
        ),
        backgroundColor: Colors.red.shade500,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      );
  static SnackBar successSnackbar(String message) => SnackBar(
        duration: duration,
        content: Text(
          message,
          style: _snackbarTextSyle,
        ),
        backgroundColor: Colors.teal.shade400,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      );
}

TextStyle _snackbarTextSyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontFamily: 'Circular',
  color: Colors.white,
  fontSize: 16,
);
