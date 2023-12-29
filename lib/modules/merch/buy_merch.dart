import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/modules/add_credit_card/add_credit_card_page.dart';
import 'package:app/modules/favourites/widgets/confirm_dialog.dart';
import 'package:app/modules/merch/widgets/tshirt.dart';

import 'package:app/shared/providers/credits_provider.dart';
import 'package:app/shared/utils/page_transitions.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BuyMerchPage extends StatefulWidget {
  const BuyMerchPage({
    super.key,
    required this.tag,
    required this.shirt,
  });

  final String tag;
  final Tshirt shirt;

  @override
  State<BuyMerchPage> createState() => _BuyMerchPageState();
}

class _BuyMerchPageState extends State<BuyMerchPage> {
  @override
  void initState() {
    super.initState();
    context.read<CreditsProvider>().getCredits();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle:
                  Theme.of(context).brightness == Brightness.dark
                      ? SystemUiOverlayStyle.light
                      : SystemUiOverlayStyle.dark,
              titleSpacing: 0,
              toolbarHeight: 60.h,
              title: Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    widget.shirt.name,
                    style: TextStyle(
                      fontSize: 20.sp,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ),
              actions: [
                const Icon(CupertinoIcons.money_dollar_circle_fill),
                wSpace(5),
                Consumer<CreditsProvider>(
                  builder: (context, provider, _) =>
                      Text(provider.credits.toString()),
                ),
                wSpace(25),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Hero(
                      tag: 't_${widget.tag}',
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              AppTheme.globalBorderRadius),
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.15),
                          image: DecorationImage(
                            image: NetworkImage(widget.shirt.imageURL),
                          ),
                        ),
                      ),
                    ),
                  ),
                  hSpace(15),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.shirt.name,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.shirt.description,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                        hSpace(5),
                        Text(
                          '₹ ${widget.shirt.price.toString()}',
                          style: TextStyle(
                            fontSize: 30.sp,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: ScreenUtil.defaultSize.width,
                          child: MainElevatedButton(
                            icon: CupertinoIcons.money_dollar_circle_fill,
                            label: 'Redeem with credits',
                            onPressed: () {
                              if (context.read<CreditsProvider>().credits <
                                  widget.shirt.price) {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    MySnackbars.error('Insufficient Credits'));
                                return;
                              }
                              showDialog(
                                context: context,
                                builder: (context) => confirmDialog(
                                  context,
                                  title: 'Redeem with credits',
                                  message:
                                      'Are you sure you want to purchase this item with credits?',
                                  onConfirm: () async => await context
                                      .read<CreditsProvider>()
                                      .spendCredits(
                                        context,
                                        widget.shirt.price,
                                      )
                                      .then((_) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      MySnackbars.success(
                                        'Purchase Succesful',
                                      ),
                                    );
                                  }).then(
                                    (_) => context
                                        .read<CreditsProvider>()
                                        .getCredits(),
                                  ),
                                  onDeny: () => Navigator.pop(context),
                                ),
                              );
                            },
                          ),
                        ),
                        hSpace(10),
                        SizedBox(
                          width: ScreenUtil.defaultSize.width,
                          child: MainElevatedButton(
                            icon: CupertinoIcons.creditcard_fill,
                            label: 'Pay with card',
                            onPressed: () {
                              Navigator.push(
                                context,
                                TransitionPageRoute(
                                  curve: Curves.ease,
                                  duration: Durations.long2,
                                  transition: PageTransitions.slideLeft,
                                  child: const AddCreditCardPage(),
                                ),
                              );
                            },
                          ),
                        ),
                        hSpace(20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
