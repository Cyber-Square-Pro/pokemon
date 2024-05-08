import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget confirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required void Function() onConfirm,
  required void Function() onDeny,
}) {
  return AlertDialog(
    backgroundColor: AppTheme.getColors(context).primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppTheme.globalBorderRadius),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    actionsPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    title: Text(
      title,
      style: _titleStyle,
    ),
    content: Text(
      message,
      style: _contentStyle,
    ),
    actions: [
      SizedBox(
        width: 100,
        child: ElevatedButton(
          onPressed: onConfirm,
          style: _buttonStyle,
          child: const Text('Yes'),
        ),
      ),
      SizedBox(
        width: 100,
        child: ElevatedButton(
          onPressed: onDeny,
          style: _buttonStyle,
          child: const Text('No'),
        ),
      ),
    ],
    actionsAlignment: MainAxisAlignment.end,
  );
}

final _buttonStyle = ButtonStyle(
  elevation: const MaterialStatePropertyAll(0),
  backgroundColor: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.pressed)) {
      return Colors.white.withOpacity(0.25);
    } else {
      return Colors.transparent;
    }
  }),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
      side: const BorderSide(
        color: Colors.white,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(AppTheme.globalBorderRadius),
    ),
  ),
  foregroundColor: const MaterialStatePropertyAll(Colors.white),
);

const _titleStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
);
final _contentStyle = TextStyle(
  color: Colors.white.withOpacity(0.5),
  fontSize: 14,
);
