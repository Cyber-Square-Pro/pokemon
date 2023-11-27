import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.label,
    required this.onPressed,
    super.key,
  });
  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,

      //
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white.withOpacity(0.95),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.globalBorderRadius),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Circular',
          fontSize: 16,
          color: Colors.blue.shade700,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
