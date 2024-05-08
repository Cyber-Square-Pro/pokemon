import 'package:app/modules/merch/widgets/shirt_provider.dart';
import 'package:app/modules/pokemon_grid/widgets/poke_item.dart';
import 'package:app/shared/providers/favourites_provider.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

showFavouritePickerDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog.fullscreen(
        child: Column(
          children: [
            hSpace(10),
            Text(
              'Select a pokemon to print',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            hSpace(10),
            Consumer<FavouritesProvider>(
              builder: (context, provider, _) {
                if (provider.state == FavouritesState.loaded) {
                  return SingleChildScrollView(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppLayouts.horizontalPagePadding,
                      ),
                      shrinkWrap: true,
                      itemCount: provider.favourites.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.3,
                      ),
                      itemBuilder: (context, index) {
                        if (provider.favourites.isEmpty) {
                          return const Text('No favourites added');
                        }
                        final pokemon = provider.favourites[index];
                        final bool currentIsSelected =
                            context.read<ShirtProvider>().selectedPokemon ==
                                pokemon;
                        if (context.read<ShirtProvider>().selectedPokemon !=
                                null &&
                            currentIsSelected) {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(
                                  AppLayouts.globalBorderRadius),
                            ),
                            child: PokeItemWidget(pokemon: pokemon),
                          );
                        } else {
                          return InkWell(
                            onTap: () {
                              context.read<ShirtProvider>().setPokemon(pokemon);
                              Navigator.pop(context);
                              print('Selected pokemon');
                            },
                            borderRadius: BorderRadius.circular(
                                AppLayouts.globalBorderRadius),
                            child: PokeItemWidget(pokemon: pokemon),
                          );
                        }
                      },
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            hSpace(10),
            Container(
              width: ScreenUtil.defaultSize.width,
              padding: EdgeInsets.symmetric(
                  horizontal: AppLayouts.horizontalPagePadding),
              child: MainElevatedButton(
                label: 'Cancel',
                onPressed: () {
                  context.read<ShirtProvider>().setPokemon(null);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
