import 'package:app/modules/daily_checkin/widgets/checkin_calendar.dart';
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
    Future.delayed(Duration.zero,
        () => context.read<CheckinProvider>().getHistory(context));
    Future.delayed(Duration.zero,
        () => context.read<CreditsProvider>().getCreditCount(context));
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero,
        () => context.read<CheckinProvider>().clearCheckinProvider());
    super.dispose();
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CheckinProvider>(
              builder: (context, provider, _) {
                if (provider.state == CheckinState.loading) {
                  return AnimatedPokeballWidget(
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 36.r,
                  );
                } else if (provider.history.isNotEmpty) {
                  // Calendar Widget
                  return CheckinCalendar(
                    provider.history,
                    firstDay: provider.data.joinDate,
                    lastDay: DateTime(2100, 12, 30),
                    focusedDay: DateTime.now(),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'You have no check-in record,\nCheckin Now to earn rewards!',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              },
            ),
            // Reward counter
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Credit Balance: '),
                Consumer<CreditsProvider>(
                  builder: (context, creditsProvider, _) => Text(
                    creditsProvider.credits.toString(),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            hSpace(10),
            // Check In Button
            //! Disable if already checked in once

            if (!context.watch<CheckinProvider>().checkedInToday)
              Consumer<CreditsProvider>(
                builder: (context, creditsProvider, _) {
                  if (creditsProvider.state == CreditState.loading) {
                    return AnimatedPokeballWidget(
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 36.r,
                    );
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
                                .read<CreditsProvider>()
                                .getCreditCount(context);
                            await context
                                .read<CheckinProvider>()
                                .checkIn(context);
                          });
                        },
                      ),
                    );
                  }
                },
              )
            else
              const Text('Already checked in for today!'),
            hSpace(15),
          ],
        ),
      ),
    );
  }
}
