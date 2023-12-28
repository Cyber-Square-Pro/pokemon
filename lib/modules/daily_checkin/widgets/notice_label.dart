import 'package:app/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoticeLabel extends StatelessWidget {
  const NoticeLabel(
    this.label, {
    super.key,
    this.icon,
    this.color,
  });

  final String label;
  final Widget? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color ?? Colors.teal.shade400,
        borderRadius: BorderRadius.circular(
          AppLayouts.globalBorderRadius,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            IconTheme(
              data: IconThemeData(
                color: Theme.of(context).colorScheme.background,
                size: 16.sp,
              ),
              child: icon!,
            ),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.background,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
