import 'package:flutter/material.dart';

Widget timerText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'Circular',
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      shadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          blurRadius: 7,
        )
      ],
    ),
  );
}
