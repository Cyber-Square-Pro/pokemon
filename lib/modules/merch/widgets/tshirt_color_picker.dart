import 'package:app/modules/merch/widgets/shirt_provider.dart';
import 'package:app/shared/utils/app_constants.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TShirtBuilder extends StatelessWidget {
  const TShirtBuilder({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<ShirtProvider>(
          builder: (context, provider, _) => Stack(
            alignment: Alignment.center,
            children: [
              provider.selectedColor != provider.colors[0]
                  ? ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          colors: provider.selectedColor != provider.colors[0]
                              ? [provider.selectedColor, provider.selectedColor]
                              : [Colors.transparent, Colors.transparent],
                        ).createShader(bounds);
                      },
                      child: Image.asset(
                        AppConstants.blankShirt,
                        width: size ?? 250.w,
                        fit: BoxFit.contain,
                      ),
                    )
                  : Image.asset(
                      AppConstants.blankShirt,
                      width: size ?? 250.w,
                      fit: BoxFit.contain,
                    ),
              // Pokemon Image print
              if (provider.selectedPokemon != null)
                Positioned(
                  top: 50.h,
                  child: Image.network(
                    provider.selectedPokemon!.imageUrl,
                    height: 110.w,
                    // loadingBuilder: (context, _, loadingProgress) {
                    //   return Center(
                    //     child: AnimatedPokeballWidget(
                    //       color: Theme.of(context).colorScheme.onBackground,
                    //       size: 30.r,
                    //     ),
                    //   );
                    // },
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
        ),
        hSpace(10),
        const Center(child: ShirtColorArray()),
      ],
    );
  }
}

class ShirtColorArray extends StatelessWidget {
  const ShirtColorArray({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ShirtProvider>();
    return GridView(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.3,
      ),
      children: provider.colors
          .map(
            (color) => ColorOption(
              color: color,
              onTap: () => provider.changeColor(color),
            ),
          )
          .toList(),
    );
  }
}

class ColorOption extends StatelessWidget {
  const ColorOption({
    super.key,
    required this.color,
    this.onTap,
  });
  final void Function()? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Consumer<ShirtProvider>(
      builder: (context, provider, _) => InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: provider.selectedColor != color ? onTap : null,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: provider.selectedColor == color ? 4 : 0,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.15),
                  blurRadius: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
