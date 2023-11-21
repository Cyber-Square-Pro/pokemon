import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:app/shared/ui/widgets/animated_pokeball.dart';
import 'package:app/theme/app_theme.dart';

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
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: widget.showBackButton,
      stretch: true,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      pinned: true,
      snap: false,
      floating: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      expandedHeight: 170.0,
      collapsedHeight: 100,
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
                'assets/images/bg/login_bg.png',
                fit: BoxFit.cover,
              ),
              if (widget.lottiePath != null)
                Positioned(
                  bottom: 10,
                  right: 0,
                  child: Lottie.asset(
                    frameRate: FrameRate.max,
                    widget.lottiePath!,
                    height: 150,
                    width: 150,
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
            const AnimatedPokeballWidget(
              size: 21,
              color: Colors.white,
            ),
            const SizedBox(
              width: 7,
            ),
            Text(
              widget.title,
              style: const TextStyle(
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
