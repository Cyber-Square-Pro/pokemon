import 'dart:io';
import 'dart:math';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/shared/providers/favourites_provider.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:app/modules/pokemon_details/pokemon_details_store.dart';
import 'package:app/modules/pokemon_details/widgets/app_bar_navigation.dart';
import 'package:app/modules/pokemon_details/widgets/pokemon_pager.dart';
import 'package:app/modules/pokemon_details/widgets/pokemon_panel/pokemon_mobile_panel.dart';
import 'package:app/modules/pokemon_details/widgets/pokemon_title_info.dart';
import 'package:app/shared/stores/pokemon_store/pokemon_store.dart';
import 'package:app/shared/ui/canvas/background_dots.dart';
import 'package:app/shared/ui/canvas/white_pokeball_canvas.dart';
import 'package:app/shared/ui/enums/device_screen_type.dart';
import 'package:app/shared/utils/converters.dart';
import 'package:app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class PokemonDetailsPage extends StatefulWidget {
  final bool isFavoritePokemon;

  const PokemonDetailsPage({Key? key, this.isFavoritePokemon = false})
      : super(key: key);

  @override
  PokemonDetailsPageState createState() => PokemonDetailsPageState();
}

class PokemonDetailsPageState extends State<PokemonDetailsPage>
    with SingleTickerProviderStateMixin {
  late PokemonStore _pokemonStore;
  late PokemonDetailsStore _pokemonDetailsStore;
  late AnimationController _animationController;
  late PageController _pageController;
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    _pokemonStore = GetIt.instance<PokemonStore>();
    _pokemonDetailsStore = PokemonDetailsStore();
    _pageController =
        PageController(initialPage: _pokemonStore.index, viewportFraction: 0.4);

    player = AudioPlayer();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    //
  }

  @override
  void dispose() {
    player.dispose();
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (getDeviceScreenType(context) == DeviceScreenType.CELLPHONE) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return ThemeSwitchingArea(
      child: Builder(builder: (context) {
        Future.delayed(
            Duration.zero,
            () => context.read<FavouritesProvider>().checkIfCurrentIsFavourite(
                context, _pokemonStore.pokemonSummary!));
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Stack(
              children: [
                Observer(
                  builder: (_) {
                    return Container(
                      height: size.height,
                      width: size.width,
                      color: AppTheme.colors
                          .pokemonItem(_pokemonStore.pokemon!.types[0]),
                    );
                  },
                ),
                Positioned(
                  top: -83 + padding.top,
                  left: -70,
                  child: Transform.rotate(
                    angle: getRadiansFromDegree(75),
                    child: Opacity(
                      opacity: 0.1,
                      child: Container(
                        height: 144,
                        width: 144,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 80,
                  top: padding.top,
                  child: Opacity(
                    opacity: 0.2,
                    child: CustomPaint(
                      size: Size(57, (57 * 0.543859649122807).toDouble()),
                      painter: BackgroundDotsPainter(),
                    ),
                  ),
                ),
                Observer(
                  builder: (_) {
                    return AppBar(
                      title: AnimatedOpacity(
                        duration: const Duration(milliseconds: 30),
                        opacity: _pokemonDetailsStore.opacityTitleAppbar,
                        child: Visibility(
                          visible: _pokemonDetailsStore.opacityTitleAppbar > 0,
                          child: AppBarNavigationWidget(),
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppTheme.getColors(context)
                              .pokemonDetailsTitleColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      actions: [
                        Consumer<FavouritesProvider>(
                          builder: (context, provider, _) {
                            if (provider.state == FavouritesState.LOADING) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                height: 21.sp,
                                width: 21.sp,
                                child: CircularProgressIndicator(
                                  strokeWidth: 4,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                              );
                            } else if (provider.state ==
                                FavouritesState.LOADED) {
                              return (provider.isFavourite)
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: AppTheme.getColors(context)
                                            .pokemonDetailsTitleColor,
                                      ),
                                      onPressed: () async {
                                        await provider.removeFavourite(context,
                                            _pokemonStore.pokemon!.number);
                                        _pokemonStore.removeFavoritePokemon(
                                            _pokemonStore.pokemon!.number);

                                        BotToast.showText(
                                            text:
                                                "${_pokemonStore.pokemon!.name} was removed from favorites");
                                      },
                                    )
                                  : IconButton(
                                      icon: Icon(Icons.favorite_border,
                                          color: AppTheme.getColors(context)
                                              .pokemonDetailsTitleColor),
                                      onPressed: () async {
                                        await provider.addFavourite(context,
                                            _pokemonStore.pokemon!.number);
                                        BotToast.showText(
                                            text:
                                                "${_pokemonStore.pokemon!.name} was favorited");
                                      },
                                    );
                            }
                            return const SizedBox();
                          },
                        ),
                        wSpace(10),
                        // if (_pokemonStore.isFavorite(_pokemonStore.pokemon!.number))
                        // if (context.read<FavouritesProvider>().isFavourite)
                        //   IconButton(
                        //     icon: Icon(
                        //       Icons.favorite,
                        //       color: AppTheme.getColors(context).pokemonDetailsTitleColor,
                        //     ),
                        //     onPressed: () async {
                        //       _pokemonStore.removeFavoritePokemon(_pokemonStore.pokemon!.number);
                        //       await favService.removeFavourite(_pokemonStore.pokemon!.number);

                        //       BotToast.showText(
                        //           text: "${_pokemonStore.pokemon!.name} was removed from favorites");
                        //     },
                        //   ),
                        // // if (!_pokemonStore.isFavorite(_pokemonStore.pokemon!.number))
                        // if (!context.read<FavouritesProvider>().isFavourite)
                        //   IconButton(
                        //     icon: Icon(Icons.favorite_border,
                        //         color: AppTheme.getColors(context).pokemonDetailsTitleColor),
                        //     onPressed: () async {
                        //       // final SharedPreferences prefs = await SharedPreferences.getInstance();
                        //       // final username = prefs.getString('username')!;

                        //       //! ADD FAVOURITE FUNCTION
                        //       if (await favService.addFavourite(
                        //           username, _pokemonStore.pokemon!.number)) {
                        //         BotToast.showText(text: 'Added favourite to mongo!');
                        //       } else {
                        //         BotToast.showText(text: 'Error/already exists!');
                        //       }
                        //       _pokemonStore.addFavoritePokemon(_pokemonStore.pokemon!.number);
                        //       BotToast.showText(text: "${_pokemonStore.pokemon!.name} was favorited");
                        //     },
                        //   ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Container(
                          width: size.width,
                          height: size.height,
                          child: Stack(
                            children: [
                              Observer(builder: (_) {
                                return Container(
                                  color: AppTheme.colors.pokemonItem(
                                      _pokemonStore.pokemon!.types[0]),
                                );
                              }),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  height: 80.h,
                                ),
                              ),
                              Observer(
                                builder: (_) => Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 30),
                                      opacity:
                                          _pokemonDetailsStore.opacityPokemon,
                                      child: SizedBox(
                                        height: 223,
                                        child: Center(
                                          child: AnimatedBuilder(
                                            animation: _animationController,
                                            builder: (_, child) {
                                              return Transform.rotate(
                                                angle:
                                                    _animationController.value *
                                                        2 *
                                                        pi,
                                                child: child,
                                              );
                                            },
                                            child: CustomPaint(
                                              size: Size(
                                                  200.h,
                                                  (200.h * 1.0040160642570282)
                                                      .toDouble()),
                                              painter: PokeballLogoPainter(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor
                                                      .withOpacity(0.3)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Observer(
                                builder: (_) => Align(
                                  alignment: Alignment.bottomCenter,
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 300),
                                    opacity:
                                        _pokemonDetailsStore.opacityPokemon,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 35),
                                      child: Container(
                                        height: 220.h,
                                        child: Stack(
                                          children: [
                                            PokemonPagerWidget(
                                              pageController: _pageController,
                                              pokemonDetailStore:
                                                  _pokemonDetailsStore,
                                              isFavorite:
                                                  widget.isFavoritePokemon,
                                            ),
                                            if ((kIsWeb &&
                                                    getDeviceScreenType(
                                                            context) !=
                                                        DeviceScreenType
                                                            .CELLPHONE) ||
                                                (!kIsWeb &&
                                                    (Platform.isWindows ||
                                                        Platform.isLinux ||
                                                        Platform.isMacOS)))
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 60),
                                                    child: InkWell(
                                                      child: Icon(
                                                        Icons.arrow_back_ios,
                                                        color: Theme.of(context)
                                                            .scaffoldBackgroundColor
                                                            .withOpacity(0.3),
                                                        size: 70.h,
                                                      ),
                                                      onTap: () {
                                                        _pageController.previousPage(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        300),
                                                            curve: Curves
                                                                .fastLinearToSlowEaseIn);
                                                      },
                                                    ),
                                                  ),
                                                  wSpace(280),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 70),
                                                    child: InkWell(
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Theme.of(context)
                                                            .scaffoldBackgroundColor
                                                            .withOpacity(0.3),
                                                        size: 60,
                                                      ),
                                                      onTap: () {
                                                        _pageController.nextPage(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        300),
                                                            curve: Curves
                                                                .fastLinearToSlowEaseIn);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Observer(
                                builder: (_) => AnimatedOpacity(
                                  duration: const Duration(milliseconds: 30),
                                  opacity: _pokemonDetailsStore.opacityPokemon,
                                  child: PokemonTitleInfoWidget(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Container(
                          width: size.width,
                          height: size.height,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: size.width,
                height: size.height,
                child: PokemonMobilePanelWidget(
                  listener: (position) {
                    _pokemonDetailsStore.setProgress(position, 0.0, 0.65);

                    return true;
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
