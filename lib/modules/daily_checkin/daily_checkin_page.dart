import 'package:app/modules/daily_checkin/widgets/checkin_calendar.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyCheckinPage extends StatefulWidget {
  const DailyCheckinPage({super.key});

  @override
  State<DailyCheckinPage> createState() => _DailyCheckinPageState();
}

class _DailyCheckinPageState extends State<DailyCheckinPage> {
  @override
  void initState() {
    super.initState();
  }

  // UI
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
            CheckinCalendar(
              firstDay: DateTime(2023, 12, 23),
              lastDay: DateTime(2100, 12, 30),
              focusedDay: DateTime.now(),
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
