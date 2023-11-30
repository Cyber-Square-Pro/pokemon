import 'package:app/modules/favourites/remove_button.dart';
import 'package:app/modules/pokemon_grid/widgets/poke_item.dart';
import 'package:app/shared/models/pokemon_summary.dart';
import 'package:app/shared/providers/favourites_provider.dart';
import 'package:app/shared/utils/error_card.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:app/shared/widgets/loading_spinner_modal.dart';
import 'package:app/theme/app_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late Dio dio;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FavouritesProvider>().getFavourites(context);
  }

  @override
  Widget build(BuildContext context) {
    // UI
    return SliverPadding(
      padding: EdgeInsets.zero,
      sliver: SliverFillRemaining(
        child: Consumer<FavouritesProvider>(
          builder: (context, provider, _) {
            // provider.getFavourites(context);
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.35,
              ),
              itemCount: provider.favourites.length,
              itemBuilder: (context, index) {
                final PokemonSummary pokemon = provider.favourites[index];
                if (provider.favourites.isEmpty) {
                  return errorCard(
                    context,
                    'Notice',
                    'Nothing has been added to your favourites',
                    AppTheme.getColors(context).panelBackground,
                  );
                } else {
                  return Stack(clipBehavior: Clip.none, fit: StackFit.loose, children: [
                    PokeItemWidget(
                      pokemon: pokemon,
                    ),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: removeButton(context, onTap: () async {
                        showLoadingSpinnerModal(context, 'Removing...');
                        if (await context
                            .read<FavouritesProvider>()
                            .removeFavourite(context, pokemon.number)) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              MySnackbars.success('Removed ${pokemon.name} from your favourites'));
                        } else {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(MySnackbars.error(
                              'Failed to remove ${pokemon.name} from your favourites'));
                        }
                      }),
                    ),
                  ]);
                }
              },
            );
          },
        ),
      ),
    );

    // return SliverFillRemaining(
    //   child: Column(
    //     children: [
    //       Center(
    //         child: ElevatedButton(
    //           child: const Text('Call Protected Route'),
    //           onPressed: () async {
    //             final prefs = await SharedPreferences.getInstance();
    //             final username = prefs.getString('username')!;

    //             final pokemons = await favService.getFavourites(username);
    //             print(pokemons);
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
