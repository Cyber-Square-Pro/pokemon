import 'package:flutter/material.dart';

const TextStyle pageTitle = TextStyle(
  color: Colors.white,
  fontFamily: 'Circular',
  letterSpacing: 0,
  fontWeight: FontWeight.bold,
  fontSize: 30,
);
final TextStyle pageTitleWithShadow = TextStyle(
  color: Colors.white,
  fontFamily: 'Circular',
  letterSpacing: 0,
  fontWeight: FontWeight.bold,
  fontSize: 30,
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
