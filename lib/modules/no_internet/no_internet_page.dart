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
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg/login_bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          physics: const BouncingScrollPhysics(),
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            hSpace(150),
            Container(
              height: 60,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage(
                    'assets/images/pokemon_logo.png',
                  ),
                ),
              ),
            ),
            hSpace(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/pokeball.png',
                  width: 40,
                ),
                wSpace(5),
                Text(
                  'No Internet',
                  style: pageTitleWithShadow,
                ),
              ],
            ),
            //Form
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Form(
                child: Column(
                  children: [
                    Lottie.asset(
                      'assets/lotties/no_internet.json',
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
            ),
          ],
        ),
      ),
    );
  }
}
