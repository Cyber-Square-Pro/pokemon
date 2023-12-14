import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/theme/dark/dark_theme.dart';
import 'package:app/theme/light/light_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:app/shared/ui/widgets/animated_pokeball.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';
import '../enums/device_screen_type.dart';

class AppBarWidget extends StatefulWidget {
  final bool showBackButton;
  final String title;
  final String? lottiePath;

  const AppBarWidget({
    Key? key,
    required this.title,
    this.lottiePath,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.light,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      automaticallyImplyLeading: widget.showBackButton,
      pinned: true,
      floating: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      expandedHeight: 150.h,
      collapsedHeight: 90.h,
      toolbarHeight: 90.h,
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade800,
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: const Icon(Icons.menu, color: Colors.white),
          ),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        background: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                AppConstants.backgroundPlainImage,
                fit: BoxFit.cover,
              ),
              if (widget.lottiePath != null)
                Positioned(
                  bottom: 12,
                  right: 0,
                  child: Lottie.asset(
                    widget.lottiePath!,
                    height: 120.h,
                    width: 120.w,
                  ),
                )
              else
                SizedBox(),
            ],
          ),
        ),
        // background: widget.lottiePath != null
        //     ? Align(
        //         alignment: Alignment.bottomRight,
        //         child: Lottie.asset(widget.lottiePath!, height: 140.0),
        //       )
        //     : Container(),
        titlePadding: const EdgeInsets.only(left: 15, bottom: 10),
        title: Row(
          children: [
            AnimatedPokeballWidget(
              size: 21.h,
              color: Colors.white,
            ),
            wSpace(10),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w900,
                fontFamily: 'Circular',
                letterSpacing: -0.5,
              ),
            ),
            if (kIsWeb && getDeviceScreenType(context) != DeviceScreenType.CELLPHONE)
              const SizedBox(
                width: 5,
              ),
            if (kIsWeb && getDeviceScreenType(context) != DeviceScreenType.CELLPHONE)
              Image.network(
                AppConstants.getRandomPokemonGif(),
                height: 32,
              )
          ],
        ),
      ),
    );
  }
}
