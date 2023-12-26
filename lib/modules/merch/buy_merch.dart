import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/modules/merch/widgets/tshirt.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuyMerchPage extends StatelessWidget {
  const BuyMerchPage({
    super.key,
    required this.id,
    required this.shirt,
  });

  final String id;
  final Tshirt shirt;

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              toolbarHeight: 60.h,
              title: Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    shirt.name,
                    style: TextStyle(
                      fontSize: 20.sp,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppTheme.globalBorderRadius),
                      child: Hero(
                        tag: 't_$id',
                        child: Image.network(
                          '',
                          width: ScreenUtil.defaultSize.width,
                          errorBuilder: (context, _, stackTrace) => Container(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.10),
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
                          shirt.name,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          shirt.description,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                        hSpace(5),
                        Text(
                          '₹ ${shirt.price.toString()}',
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
                            onPressed: () {},
                          ),
                        ),
                        hSpace(10),
                        SizedBox(
                          width: ScreenUtil.defaultSize.width,
                          child: MainElevatedButton(
                            icon: CupertinoIcons.creditcard_fill,
                            label: 'Pay with card',
                            onPressed: () {},
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
