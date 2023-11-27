import 'package:app/shared/utils/app_constants.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({super.key});

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppConstants.backgroundPlainImage),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No Internet',
              style: pageTitleWithShadow,
            ),

            //Form
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Column(
                children: [
                  Lottie.asset(
                    AppConstants.noInternetLottie,
                    animate: true,
                    fit: BoxFit.contain,
                    height: 100,
                    width: 100,
                  ),
                  hSpace(20),
                  Text(
                    'Failed to connect to pokemon services, please check your internet.',
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: pageSubtitle,
                  ),
                  hSpace(20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
