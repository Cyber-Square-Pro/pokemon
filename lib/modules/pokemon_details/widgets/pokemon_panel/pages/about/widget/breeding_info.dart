import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:app/shared/models/pokemon.dart';
import 'package:app/shared/stores/pokemon_store/pokemon_store.dart';
import 'package:app/theme/app_theme.dart';

class BreedingInfoWidget extends StatelessWidget {
  static final _pokemonStore = GetIt.instance<PokemonStore>();

  const BreedingInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 9),
              child: Text(
                "Breeding",
                style:
                    textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        child: Observer(
                          builder: (_) => Row(
                            children: [
                              SizedBox(
                                width: 88,
                                child: Opacity(
                                  opacity: 0.4,
                                  child: Text(
                                    "Gender",
                                    style: textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                              ..._pokemonStore.pokemon!.breeding.genders
                                  .map((gender) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Row(
                                    children: [
                                      if (gender.type == GenderType.MALE)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 5,
                                          ),
                                          child: FaIcon(
                                            FontAwesomeIcons.mars,
                                            color: AppTheme.getColors(context)
                                                .marsIcon,
                                          ),
                                        ),
                                      if (gender.type == GenderType.FEMALE)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 5,
                                          ),
                                          child: FaIcon(
                                            FontAwesomeIcons.venus,
                                            color: AppTheme.getColors(context)
                                                .venusIcon,
                                          ),
                                        ),
                                      if (gender.type == GenderType.UNKNOWN)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            "???",
                                            style: textTheme.bodyMedium,
                                          ),
                                        ),
                                      Text(
                                        gender.type == GenderType.UNKNOWN
                                            ? "--%"
                                            : "${gender.percentage}",
                                        style: textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 88,
                              child: Opacity(
                                opacity: 0.4,
                                child: Text("Egg Groups",
                                    style: textTheme.bodyMedium),
                              ),
                            ),
                            Observer(
                              builder: (_) => Text(
                                _pokemonStore.pokemon!.breeding.egg!.groups
                                    .join(", "),
                                style: textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 88,
                              child: Opacity(
                                opacity: 0.4,
                                child: Text(
                                  "Egg Cycle",
                                  style: textTheme.bodyMedium,
                                ),
                              ),
                            ),
                            Observer(
                              builder: (_) => Text(
                                _pokemonStore.pokemon!.breeding.egg!.cycle,
                                style: textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
