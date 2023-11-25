import 'package:app/shared/utils/spacer.dart';
import 'package:flutter/material.dart';

class CustomSnackbars {
  static Duration duration = const Duration(seconds: 2);
  static SnackBar errorSnackbar(String message, [String title = 'Error!']) => SnackBar(
        duration: duration,
        content: snackbarBase(
          'assets/images/ash_shocked.png',
          Colors.red.shade500,
          Text(
            message,
            style: _snackbarMessageSyle,
            maxLines: 2,
          ),
          title,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.none,
      );
  static SnackBar successSnackbar(String message, [String title = 'success']) => SnackBar(
        duration: duration,
        content: snackbarBase(
          '',
          Colors.teal.shade400,
          Text(
            message,
            style: _snackbarMessageSyle,
            maxLines: 2,
          ),
          title,
        ),
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.none,
      );
}

Widget snackbarBase(String imagePath, Color color, Widget child, String title) => Stack(
      fit: StackFit.loose,
      clipBehavior: Clip.none,
      alignment: Alignment.centerLeft,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: color,
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                color: Colors.black.withOpacity(0.5),
              )
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              wSpace(75),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: _snackbarTitleSyle,
                    ),
                    child,
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          bottom: 10,
          child: imagePath != ''
              ? Image.asset(
                  'assets/images/ash_shocked.png',
                  height: 100,
                  width: 100,
                )
              : const SizedBox(),
        ),
      ],
    );
TextStyle _snackbarTitleSyle = const TextStyle(
  height: 1.3,
  fontFamily: 'Circular',
  fontWeight: FontWeight.bold,
  color: Colors.white,
  overflow: TextOverflow.ellipsis,
  fontSize: 16,
);
TextStyle _snackbarMessageSyle = TextStyle(
  height: 1.1,
  fontFamily: 'Circular',
  fontWeight: FontWeight.normal,
  color: Colors.white.withOpacity(0.6),
  overflow: TextOverflow.ellipsis,
  fontSize: 13,
);
