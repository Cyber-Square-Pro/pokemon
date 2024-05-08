import 'package:app/shared/providers/favourites_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:app/modules/pokemon_details/pokemon_details_store.dart';
import 'package:app/shared/stores/pokemon_store/pokemon_store.dart';
import 'package:app/shared/utils/image_utils.dart';
import 'package:provider/provider.dart';

class PokemonPagerWidget extends StatefulWidget {
  final PageController pageController;
  final PokemonDetailsStore pokemonDetailStore;
  final bool isFavorite;

  const PokemonPagerWidget({
    super.key,
    required this.pageController,
    required this.pokemonDetailStore,
    this.isFavorite = false,
  });

  @override
  // ignore: no_logic_in_create_state
  PokemonPagerState createState() => PokemonPagerState(pageController);
}

class PokemonPagerState extends State<PokemonPagerWidget> {
  final PageController pageController;
  late PokemonStore _pokemonStore = GetIt.instance<PokemonStore>();
  late ReactionDisposer _updatePagerReaction;

  PokemonPagerState(this.pageController);

  @override
  void initState() {
    super.initState();

    _pokemonStore = GetIt.instance<PokemonStore>();

    _updatePagerReaction = autorun((_) async => {
          if (widget.pokemonDetailStore.opacityTitleAppbar == 1 &&
              _pokemonStore.index != pageController)
            {
              await pageController.animateToPage(_pokemonStore.index,
                  duration: const Duration(microseconds: 300),
                  curve: Curves.bounceIn),
            }
        });
  }

  @override
  void dispose() {
    _updatePagerReaction();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 223 * MediaQuery.of(context).devicePixelRatio,
      child: PageView.builder(
        controller: pageController,
        itemCount: _pokemonStore.pokemonsSummary!.length,
        onPageChanged: (index) async {
          _pokemonStore.setPokemon(index);
          context.read<FavouritesProvider>().checkIfCurrentIsFavourite(
                context,
                _pokemonStore.pokemonSummary!,
              );
          context.read<FavouritesProvider>().fetchFavourites(context);
        },
        allowImplicitScrolling: true,
        itemBuilder: (context, index) {
          final listPokemon = _pokemonStore.pokemonsSummary![index];

          return Observer(
            builder: (_) {
              return AnimatedPadding(
                padding: EdgeInsets.all(
                    _pokemonStore.pokemonSummary!.number == listPokemon.number
                        ? 0
                        : 40),
                duration: const Duration(milliseconds: 300),
                child: Container(
                  child:
                      _pokemonStore.pokemonSummary!.number == listPokemon.number
                          ? Hero(
                              tag: widget.isFavorite
                                  ? "favorite-pokemon-image-${listPokemon.number}"
                                  : "pokemon-image-${listPokemon.number}",
                              child: ImageUtils.networkImage(
                                url: listPokemon.imageUrl,
                                height: 300,
                                color: _pokemonStore.pokemonSummary!.number ==
                                        listPokemon.number
                                    ? null
                                    : Colors.black.withOpacity(0.2),
                              ),
                            )
                          : ImageUtils.networkImage(
                              url: listPokemon.imageUrl,
                              height: 300,
                              color: _pokemonStore.pokemonSummary!.number ==
                                      listPokemon.number
                                  ? null
                                  : Colors.black.withOpacity(0.2),
                            ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
