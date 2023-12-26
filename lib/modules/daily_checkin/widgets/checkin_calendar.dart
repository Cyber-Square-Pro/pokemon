import 'package:app/shared/models/daily_checkin_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class CheckinCalendar extends StatelessWidget {
  const CheckinCalendar(
    this.data, {
    super.key,
    required this.firstDay,
    required this.lastDay,
    required this.focusedDay,
  });

  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime focusedDay;
  final List<History> data;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context).colorScheme;
    return TableCalendar(
      calendarStyle: _calStyle(context),
      headerStyle: _headerStyle(context),
      weekNumbersVisible: false,
      focusedDay: focusedDay,
      firstDay: firstDay,
      lastDay: lastDay,

      // Builders
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, currentDate, events) {
          final History? status = data.firstWhereOrNull(
            (element) => element.createdAt.day == currentDate.day,
          );
          if (status != null) {
            return status.isCheckedIn == true
                ? Container(
                    width: 30.w,
                    height: 5.h,
                    color: Colors.green,
                  )
                : Container(
                    width: 30.w,
                    height: 5.h,
                    color: Colors.red,
                  );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

CalendarStyle _calStyle(BuildContext context) {
  final theme = Theme.of(context).colorScheme;
  return CalendarStyle(
    tablePadding: EdgeInsets.only(
      top: 10.h,
    ),
    selectedDecoration: BoxDecoration(
      color: theme.primary,
    ),
    todayDecoration: BoxDecoration(
      color: theme.primary.withOpacity(0.75),
      borderRadius: BorderRadius.circular(10.r),
    ),
    markerDecoration: BoxDecoration(
      color: theme.primary.withOpacity(0.25),
      borderRadius: BorderRadius.circular(10.r),
    ),
    todayTextStyle: TextStyle(
      color: theme.onPrimary,
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
    ),
  );
}

HeaderStyle _headerStyle(BuildContext context) {
  final theme = Theme.of(context).colorScheme;
  return HeaderStyle(
    decoration: BoxDecoration(
      color: theme.primary,
      borderRadius: BorderRadius.circular(15.r),
    ),
    titleCentered: true,
    titleTextStyle: TextStyle(
      color: theme.onPrimary,
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      letterSpacing: 0,
      height: 1,
    ),
    headerPadding: EdgeInsets.zero,
    leftChevronIcon: Icon(
      CupertinoIcons.left_chevron,
      color: theme.onPrimary,
    ),
    rightChevronIcon: Icon(
      CupertinoIcons.right_chevron,
      color: theme.onPrimary,
    ),
  );
}
