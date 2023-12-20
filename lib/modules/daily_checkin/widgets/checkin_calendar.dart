import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class CheckinData {
  CheckinData({
    required this.date,
    required this.isChecked,
  });
  final DateTime date;
  final bool isChecked;
}

final List<CheckinData> data = [
  CheckinData(date: DateTime(2023, 12, 20), isChecked: true),
  CheckinData(date: DateTime(2023, 12, 21), isChecked: true),
  CheckinData(date: DateTime(2023, 12, 22), isChecked: false),
  CheckinData(date: DateTime(2023, 12, 23), isChecked: true),
  CheckinData(date: DateTime(2023, 12, 25), isChecked: true),
];

class CheckinCalendar extends StatefulWidget {
  const CheckinCalendar({
    super.key,
    required this.firstDay,
    required this.lastDay,
    required this.focusedDay,
  });

  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime focusedDay;

  @override
  State<CheckinCalendar> createState() => _CheckinCalendarState();
}

class _CheckinCalendarState extends State<CheckinCalendar> {
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context).colorScheme;
    return TableCalendar(
      calendarStyle: _calStyle(context),
      headerStyle: _headerStyle(context),
      weekNumbersVisible: false,
      focusedDay: widget.focusedDay,
      firstDay: widget.firstDay,
      lastDay: widget.lastDay,

      // Builders
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, currentDate, events) {
          final CheckinData? status = data.firstWhereOrNull(
            (element) => isSameDay(element.date, currentDate),
          );
          if (status != null) {
            return status.isChecked
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
            return const SizedBox.shrink();
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
      color: theme.primary.withOpacity(0.5),
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
