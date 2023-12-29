import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardSelectionPage extends StatefulWidget {
  const CardSelectionPage({super.key});

  @override
  State<CardSelectionPage> createState() => _CardSelectionPageState();
}

class _CardSelectionPageState extends State<CardSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        key: const Key('card_selector'),
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              toolbarHeight: 60.h,
              title: Text(
                'Choose your card',
                style: TextStyle(
                  fontSize: 20.sp,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            body: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              ),
            ),
          );
        },
      ),
    );
  }
}
