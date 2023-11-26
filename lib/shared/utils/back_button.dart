// import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';

Widget backButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: CircleAvatar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.black.withOpacity(0.5),
      radius: 12,
      child: IconButton(
        enableFeedback: true,
        splashRadius: 16,
        tooltip: 'Back',
        color: Colors.white,
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back,
          shadows: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
            )
          ],
        ),
      ),
    ),
  );
}
