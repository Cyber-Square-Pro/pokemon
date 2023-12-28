import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:app/modules/pokemon_details/widgets/pokemon_panel/pages/base_stats/utils/table_row_factory.dart';
import 'package:app/modules/pokemon_details/widgets/pokemon_panel/pages/base_stats/widgets/base_stats_item.dart';
import 'package:app/shared/stores/pokemon_store/pokemon_store.dart';

import '../../pokemon_mobile_panel.dart';

class BaseStatsPage extends StatelessWidget {
  static final _pokemonStore = GetIt.instance<PokemonStore>();

  const BaseStatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final size = MediaQuery.of(context).size;

    final horizontalPadding = getDetailsPanelsPadding(size);

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            children: [
              BaseStatsItemWidget(
                title: "HP",
              ),
              BaseStatsItemWidget(
                title: "Attack",
              ),
              BaseStatsItemWidget(
                title: "Defense",
              ),
              BaseStatsItemWidget(
                title: "Sp. Atk",
              ),
              BaseStatsItemWidget(
                title: "Sp. Def",
              ),
              BaseStatsItemWidget(
                title: "Speed",
              ),
              BaseStatsItemWidget(
                title: "Total",
                maxValue: 1200,
              ),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            "Type Effectiveness",
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Observer(
            builder: (_) => Table(
              columnWidths: const {0: FixedColumnWidth(100)},
              children: [
                TableRowFactory.build(context,
                    title: "Damaged normally by",
                    types: _pokemonStore.pokemon!.typesEffectiveness.entries
                        .where((it) => it.value == "1")),
                TableRowFactory.build(context,
                    title: "Weak to",
                    types: _pokemonStore.pokemon!.typesEffectiveness.entries
                        .where((it) => it.value == "2")),
                TableRowFactory.build(context,
                    title: "Resistant to",
                    types: _pokemonStore.pokemon!.typesEffectiveness.entries
                        .where((it) => it.value == "½" || it.value == "¼")),
                TableRowFactory.build(context,
                    title: "Immune to",
                    types: _pokemonStore.pokemon!.typesEffectiveness.entries
                        .where((it) => it.value == "0")),
              ],
            ),
          ),
          const SizedBox(
            height: 300,
          )
        ],
      ),
    );
  }
}
