import 'package:app/shared/utils/app_constants.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MySnackbars {
  static Duration duration = const Duration(seconds: 3);
  static SnackBar error(String message, [String title = 'Error!']) => SnackBar(
        duration: duration,
        content: snackbarBase(
          AppConstants.ashShockedImage,
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
  static SnackBar success(String message, [String title = 'success']) => SnackBar(
        duration: duration,
        content: snackbarBase(
          AppConstants.ashThrowImage,
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
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: color,
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                color: Colors.black.withOpacity(0.5),
              )
            ],
            borderRadius: BorderRadius.circular(AppTheme.globalBorderRadius),
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
          left: 10,
          bottom: 20,
          child: imagePath != ''
              ? Image.asset(
                  imagePath,
                  height: 100,
                  width: 100,
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
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
