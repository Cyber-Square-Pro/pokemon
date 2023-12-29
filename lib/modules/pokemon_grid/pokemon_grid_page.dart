import 'package:app/shared/widgets/loading_spinner.dart';
import 'package:app/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:app/modules/pokemon_grid/widgets/pokemon_grid.dart';
import 'package:app/shared/stores/pokemon_store/pokemon_store.dart';
import 'package:app/shared/utils/app_constants.dart';

class PokemonGridPage extends StatefulWidget {
  const PokemonGridPage({super.key});

  @override
  PokemonGridPageState createState() => PokemonGridPageState();
}

class PokemonGridPageState extends State<PokemonGridPage> {
  late PokemonStore _pokemonStore;

  @override
  void initState() {
    super.initState();

    _pokemonStore = GetIt.instance<PokemonStore>();

    _fetchPokemonData();
  }

  Future<void> _fetchPokemonData() async {
    await _pokemonStore.fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Observer(
      builder: (_) {
        if (_pokemonStore.pokemonsSummary == null) {
          return SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loadingSpinner(context),
              ],
            ),
          );
        } else {
          if (_pokemonStore.pokemonFilter.pokemonNameNumberFilter != null &&
              _pokemonStore.pokemonsSummary!.isEmpty) {
            return SliverToBoxAdapter(
              child: SizedBox(
                height: 250.h,
                width: 250.w,
                child: Stack(
                  children: [
                    Center(
                      child: Lottie.asset(
                        AppConstants.pikachuLottie,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          "${_pokemonStore.pokemonFilter.pokemonNameNumberFilter} was not found",
                          style: textTheme.bodySmall!,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }

          return SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: AppLayouts.horizontalPagePadding),
            sliver: PokemonGridWidget(pokemonStore: _pokemonStore),
          );
        }
      },
    );
  }
}
