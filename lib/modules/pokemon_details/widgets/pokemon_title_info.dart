import 'package:app/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:app/shared/stores/pokemon_store/pokemon_store.dart';
import 'package:app/theme/app_theme.dart';

class PokemonTitleInfoWidget extends StatelessWidget {
  final _pokemonStore = GetIt.instance<PokemonStore>();

  PokemonTitleInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Observer(builder: (_) {
                return Text(
                  _pokemonStore.pokemon!.name,
                  style: textTheme.titleSmall?.copyWith(
                    fontFamily: 'Circular',
                    letterSpacing: -1,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.getColors(context).pokemonDetailsTitleColor,
                  ),
                );
              }),
              Observer(
                builder: (_) {
                  return Text(
                    "#${_pokemonStore.pokemon!.number}",
                    style: textTheme.titleSmall?.copyWith(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.getColors(context)
                          .pokemonDetailsTitleColor
                          .withOpacity(0.5),
                    ),
                  );
                },
              ),
            ],
          ),
          hSpace(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Observer(
                builder: (_) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _pokemonStore.pokemon!.types
                        .map(
                          (type) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.r),
                                color: AppTheme.getColors(context)
                                    .pokemonDetailsTitleColor
                                    .withOpacity(0.2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 5,
                                ),
                                child: Text(
                                  type,
                                  style: textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.getColors(context)
                                        .pokemonDetailsTitleColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              Observer(
                builder: (_) {
                  return Text("${_pokemonStore.pokemon!.specie} Pokemon",
                      style: textTheme.bodySmall?.copyWith(
                        color: AppTheme.getColors(context)
                            .pokemonDetailsTitleColor,
                      ));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
