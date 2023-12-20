import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class DailyCheckinPage extends StatefulWidget {
  const DailyCheckinPage({
    super.key,
  });

  @override
  State<DailyCheckinPage> createState() => _DailyCheckinPageState();
}

class _DailyCheckinPageState extends State<DailyCheckinPage> {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
        ),
        child: Column(
          children: [
            // Calendar Widget
            TableCalendar(
              calendarStyle: _calStyle(context),
              headerStyle: _headerStyle(context),
              weekNumbersVisible: false,
              focusedDay: DateTime.now(),
              firstDay: DateTime.now(),
              lastDay: DateTime(2030),
            ),
            // Reward counter
            const Spacer(),
            // Check In Button
            //! Disable if already checked in once
            SizedBox(
              width: double.infinity,
              child: MainElevatedButton(
                label: 'Check In',
                icon: Icons.check,
                onPressed: () {},
              ),
            ),
            hSpace(10),
          ],
        ),
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
      color: theme.primary,
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
