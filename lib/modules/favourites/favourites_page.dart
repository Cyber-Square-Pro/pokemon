import 'package:app/modules/favourites/widgets/confirm_dialog.dart';
import 'package:app/modules/favourites/widgets/remove_button.dart';
import 'package:app/modules/pokemon_grid/widgets/poke_item.dart';
import 'package:app/shared/models/pokemon_summary.dart';
import 'package:app/shared/providers/favourites_provider.dart';
import 'package:app/shared/ui/widgets/animated_pokeball.dart';
import 'package:app/shared/utils/error_card.dart';
import 'package:app/shared/utils/snackbars.dart';
import 'package:app/shared/widgets/loading_spinner_modal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    super.initState();

    //
    Future.delayed(
      Duration.zero,
      () => context.read<FavouritesProvider>().fetchFavourites(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    // UI
    return SliverToBoxAdapter(
      child: Consumer<FavouritesProvider>(
        builder: (context, provider, _) {
          if (provider.state == FavouritesState.loading) {
            return Center(
              child: AnimatedPokeballWidget(
                color: Theme.of(context).textTheme.bodySmall!.color!,
                size: 40.h,
              ),
            );
          } else if (provider.state == FavouritesState.error) {
            return Center(
              child: errorCard(
                context,
                'Error',
                'Failed to get favourites',
                Colors.red.shade600,
                75,
              ),
            );
          } else if (provider.state == FavouritesState.loaded &&
              provider.favourites.isEmpty) {
            return SizedBox(
              height: 100,
              child: Column(
                children: [
                  errorCard(
                    context,
                    'Notice',
                    'You have no favourites added.',
                    Colors.grey.shade800,
                  ),
                ],
              ),
            );
          }
          return GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(
              bottom: 20,
              right: 10.w,
              left: 10.w,
            ),
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

              return Stack(
                clipBehavior: Clip.none,
                fit: StackFit.loose,
                children: [
                  PokeItemWidget(
                    pokemon: pokemon,
                  ),
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: removeButton(context, onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) => confirmDialog(
                          title: 'Remove Favourite',
                          message:
                              'Are you sure you want to remove ${pokemon.name} from your favourites?',
                          onConfirm: () async {
                            showLoadingSpinnerModal(
                                context, 'Removing favourite...');
                            if (await context
                                .read<FavouritesProvider>()
                                .removeFavourite(
                                  context,
                                  pokemon.number,
                                )) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  MySnackbars.success(
                                      'Removed ${pokemon.name} from your favourites'));
                            } else {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  MySnackbars.error(
                                      'Failed to remove ${pokemon.name} from your favourites'));
                            }
                          },
                          onDeny: () => Navigator.pop(context),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
