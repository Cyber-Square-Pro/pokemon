import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app/shared/stores/pokemon_store/pokemon_store.dart';
import 'package:app/shared/utils/image_utils.dart';
import 'package:app/theme/app_theme.dart';

class AppBarNavigationWidget extends StatelessWidget {
  final _pokemonStore = GetIt.instance<PokemonStore>();

  AppBarNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme themeData = Theme.of(context).textTheme;

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_pokemonStore.index > 0)
            InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: AppTheme.getColors(context).pokemonDetailsTitleColor,
              ),
              onTap: () async {
                _pokemonStore.previousPokemon();
              },
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6, right: 5),
            child: ImageUtils.networkImage(
                height: 35,
                width: 35,
                url: _pokemonStore.pokemon!.sprites.mainSpriteUrl),
          ),
          Text(
            _pokemonStore.pokemon!.name,
            style: themeData.titleSmall?.copyWith(
              fontSize: 15,
              color: AppTheme.getColors(context).pokemonDetailsTitleColor,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          if (_pokemonStore.index < _pokemonStore.pokemonsSummary!.length - 1)
            InkWell(
              onTap: () async {
                _pokemonStore.nextPokemon();
              },
              child: Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: AppTheme.getColors(context).pokemonDetailsTitleColor,
              ),
            ),
        ],
      ),
    );
  }
}
