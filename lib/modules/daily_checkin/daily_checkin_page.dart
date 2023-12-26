import 'package:app/modules/daily_checkin/widgets/checkin_calendar.dart';
import 'package:app/shared/providers/daily_checkin_provider.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DailyCheckinPage extends StatefulWidget {
  const DailyCheckinPage({super.key});

  @override
  State<DailyCheckinPage> createState() => _DailyCheckinPageState();
}

class _DailyCheckinPageState extends State<DailyCheckinPage> {
  @override
  void initState() {
    super.initState();
    context.read<CheckinProvider>().getHistory(context);
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
        ),
        child: Consumer<CheckinProvider>(
          builder: (context, provider, _) {
            return Column(
              children: [
                // Calendar Widget
                if (provider.history.isEmpty)
                  const Center(
                    child: Text(
                      'You have no check-in record, Checkin Now to earn rewards!',
                    ),
                  )
                else
                  CheckinCalendar(
                    provider.history,
                    firstDay: provider.data.joinDate,
                    lastDay: DateTime(2100, 12, 30),
                    focusedDay: DateTime.now(),
                  ),
                // Reward counter
                const Spacer(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Credits Balance: '),
                    Text('000'),
                  ],
                ),
                hSpace(10),
                // Check In Button
                //! Disable if already checked in once
                (() {
                  if (!provider.checkedInToday) {
                    return SizedBox(
                      width: double.infinity,
                      child: MainElevatedButton(
                        label: 'Check In',
                        icon: Icons.check,
                        onPressed: () async {
                          await provider.checkIn(context);
                        },
                      ),
                    );
                  }
                  return const Text('You have already checked in.');
                }()),

                hSpace(15),
              ],
            );
          },
        ),
      ),
    );
  }
}
