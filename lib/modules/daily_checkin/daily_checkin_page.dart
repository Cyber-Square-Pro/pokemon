import 'package:app/modules/daily_checkin/widgets/checkin_calendar.dart';
import 'package:app/modules/daily_checkin/widgets/notice_label.dart';
import 'package:app/shared/providers/credits_provider.dart';
import 'package:app/shared/providers/daily_checkin_provider.dart';
import 'package:app/shared/ui/widgets/animated_pokeball.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DailyCheckinPage extends StatefulWidget {
  const DailyCheckinPage({super.key});

  @override
  State<DailyCheckinPage> createState() => _DailyCheckinPageState();
}

class _DailyCheckinPageState extends State<DailyCheckinPage> {
  late CheckinProvider checkinProvider;
  late CreditsProvider creditsProvider;
  @override
  void initState() {
    super.initState();
    checkinProvider = context.read<CheckinProvider>();
    // creditsProvider = context.read<CreditsProvider>();
  }

  // UI
  @override
  Widget build(BuildContext context) {
    creditsProvider = Provider.of<CreditsProvider>(context, listen: true);

    return SliverFillRemaining(
      fillOverscroll: false,
      key: const Key('checkin_page'),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppLayouts.horizontalPagePadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: checkinProvider.fromHistoryStream(context),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return AnimatedPokeballWidget(
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 36.r,
                  );
                }
                if (checkinProvider.history.isEmpty) {
                  return const Center(
                    child: Text(
                      'You have no check-in record,\nCheckin Now to earn rewards!',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return CheckinCalendar(
                  checkinProvider.history,
                  firstDay: checkinProvider.data.joinDate,
                  lastDay: DateTime(2100, 12, 30),
                  focusedDay: DateTime.now(),
                );
              },
            ),

            // Reward counter
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Credit Balance: '),
                StreamBuilder(
                  stream: creditsProvider.fromCreditStream(context),
                  initialData: 0.0,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    print(snapshot.data);
                    return Text(
                      snapshot.data.toString(),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
            hSpace(10),
            // Check In Button
            //! Disable if already checked in once

            Consumer<CreditsProvider>(
              builder: (context, checkinProvider, _) {
                if (checkinProvider.state == CreditState.loading) {
                  return AnimatedPokeballWidget(
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 36.r,
                  );
                } else if (Provider.of<CheckinProvider>(context)
                    .checkedInToday) {
                  return const NoticeLabel('Already checked in for today!');
                } else {
                  return SizedBox(
                    width: double.infinity,
                    child: MainElevatedButton(
                      label: 'Check In',
                      icon: Icons.check,
                      onPressed: () {
                        Future.delayed(Duration.zero, () async {
                          await context
                              .read<CreditsProvider>()
                              .addCredits(context);
                          await context
                              .read<CheckinProvider>()
                              .checkIn(context);
                        });
                      },
                    ),
                  );
                }
              },
            ),
            hSpace(20),
          ],
        ),
      ),
    );
  }
}
