import 'package:app/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:app/shared/models/pokemon_summary.dart';
import 'package:app/shared/ui/canvas/white_pokeball_canvas.dart';
import 'package:app/shared/utils/image_utils.dart';
import 'package:app/theme/app_theme.dart';

class PokeItemWidget extends StatelessWidget {
  final PokemonSummary pokemon;
  final bool isFavorite;

  const PokeItemWidget({
    Key? key,
    required this.pokemon,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getColors(context).pokemonItem(pokemon.types[0]),
        boxShadow: [
          BoxShadow(
            color: AppTheme.getColors(context)
                .pokemonItem(pokemon.types[0])
                .withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(-1, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned(
              bottom: -15,
              right: -3,
              child: CustomPaint(
                size: Size(
                    85,
                    (85 * 1.0040160642570282)
                        .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: PokeballLogoPainter(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 7, bottom: 10),
                child: SizedBox(
                  height: 76,
                  width: 76,
                  child: Hero(
                    tag: isFavorite
                        ? "favorite-pokemon-image-${pokemon.number}"
                        : "pokemon-image-${pokemon.number}",
                    child: ImageUtils.networkImage(
                      url: pokemon.thumbnailUrl,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, top: 8),
                child: Text(
                  "#${pokemon.number}",
                  style: TextStyle(
                    fontFamily: "Circular",
                    fontSize: 20,
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.getColors(context)
                        .pokemonDetailsTitleColor
                        .withOpacity(0.5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon.name,
                    style: textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Circular',
                        fontSize: 15,
                        letterSpacing: 0,
                        color: AppTheme.getColors(context)
                            .pokemonDetailsTitleColor),
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: pokemon.types
                        .map((type) => Padding(
                              padding: const EdgeInsets.only(
                                top: 4,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(38),
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
                                      fontSize: 12,
                                      fontFamily: 'Circular',
                                      fontWeight: FontWeight.normal,
                                      color: AppTheme.getColors(context)
                                          .pokemonDetailsTitleColor,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  hSpace(5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
