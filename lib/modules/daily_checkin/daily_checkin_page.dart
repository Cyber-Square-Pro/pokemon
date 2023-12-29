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
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<CheckinProvider>().getHistory(context);
    });
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      fillOverscroll: false,
      key: const Key('checkin_page'),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppLayouts.horizontalPagePadding,
        ),
        child: Column(
          children: [
            Consumer<CheckinProvider>(
              builder: (context, checkinProvider, _) {
                if (checkinProvider.state == CheckinState.loading) {
                  return Center(
                    child: AnimatedPokeballWidget(
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 36.r,
                    ),
                  );
                } else {
                  return CheckinCalendar(
                    checkinProvider.history,
                    firstDay: checkinProvider.data.joinDate,
                    lastDay: DateTime(2100, 12, 30),
                    focusedDay: DateTime.now(),
                  );
                }
              },
            ),

            hSpace(10),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Credit Balance: '),
                StreamBuilder(
                  stream:
                      context.read<CreditsProvider>().fromCreditStream(context),
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

            // Check In Button
            //! Disable if already checked in once

            Consumer<CheckinProvider>(
              builder: (context, provider, _) {
                print(provider.checkedInToday);
                if (provider.state == CheckinState.loading) {
                  return AnimatedPokeballWidget(
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 36.r,
                  );
                } else if (provider.checkedInToday) {
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
                              .addCredits(context)
                              .then((_) async {
                            await context
                                .read<CheckinProvider>()
                                .checkIn(context)
                                .then((_) {
                              context
                                  .read<CheckinProvider>()
                                  .getHistory(context);
                            });
                          });
                        });
                      },
                    ),
                  );
                }
              },
            ),
            hSpace(15),
          ],
        ),
      ),
    );
  }
}
