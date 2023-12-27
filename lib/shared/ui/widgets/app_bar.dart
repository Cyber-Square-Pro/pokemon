import 'package:app/shared/utils/spacer.dart';
import 'package:app/theme/app_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:app/shared/ui/widgets/animated_pokeball.dart';

import 'package:app/shared/utils/app_constants.dart';
import 'package:app/shared/ui/enums/device_screen_type.dart';

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
  AppBarWidgetState createState() => AppBarWidgetState();
}

class AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: widget.showBackButton,
      pinned: true,
      floating: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppLayouts.globalBorderRadius,
        ),
      ),
      expandedHeight: 140.h,
      collapsedHeight: 80.h,
      toolbarHeight: 75.h,
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade800,
      actions: [
        IconButton(
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
          ),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
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
                  bottom: 7,
                  right: 20,
                  child: Lottie.asset(
                    widget.lottiePath!,
                    height: 120.h,
                    width: 120.w,
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
        ),
        titlePadding: const EdgeInsets.only(
          left: 15,
          bottom: 10,
          top: 10,
        ),
        title: Row(
          children: [
            AnimatedPokeballWidget(
              size: 18.h,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
            ),
            wSpace(10),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black
                        : Colors.white,
                  ),
            ),
            if (kIsWeb &&
                getDeviceScreenType(context) != DeviceScreenType.cellphone)
              const SizedBox(
                width: 5,
              ),
            if (kIsWeb &&
                getDeviceScreenType(context) != DeviceScreenType.cellphone)
              Image.network(
                AppConstants.getRandomPokemonGif(),
                height: 32,
              ),
          ],
        ),
      ),
    );
  }
}
