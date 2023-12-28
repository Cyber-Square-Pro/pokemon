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

class MainElevatedButton extends StatelessWidget {
  const MainElevatedButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return ElevatedButton(
        onPressed: onPressed,
        style: _mainButtonStyle(context),
        child: Text(label),
      );
    } else {
      return ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        style: _mainButtonStyle(context),
        label: Text(label),
      );
    }
  }
}

ButtonStyle _mainButtonStyle(BuildContext context) {
  final theme = Theme.of(context).colorScheme;
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) {
        return AppTheme.getColors(context).primaryColor.withOpacity(0.5);
      } else {
        return AppTheme.getColors(context).primaryColor;
      }
    }),
    foregroundColor: MaterialStatePropertyAll(
      theme.background,
    ),
    padding: const MaterialStatePropertyAll(
      EdgeInsets.symmetric(horizontal: 15, vertical: 12.5),
    ),
    textStyle: MaterialStatePropertyAll(
      TextStyle(
        fontFamily: 'Circular',
        fontWeight: FontWeight.bold,
        fontSize: 15.sp,
      ),
    ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
        side: BorderSide.none,
      ),
    ),
  );
}
