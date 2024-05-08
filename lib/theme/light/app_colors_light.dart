import 'package:flutter/material.dart';

import '../app_theme.dart';

class AppColorsLight extends AppColors {
  const AppColorsLight();

  @override
  Color get pokemonTabTitle => const Color(0xFF303943).withOpacity(0.4);

  @override
  Color get selectPokemonTabTitle => const Color(0xFF303943);

  @override
  Color get selectedGenerationFilter =>
      const Color(0xFF666666).withOpacity(0.4);

  @override
  Color get pokeballLogoBlack => const Color(0xFF303943);

  @override
  Color get pokeballLogoGray => const Color(0xFF303943).withOpacity(0.1);

  @override
  Color get generationFilter => const Color(0xFFFFFFFF);

  @override
  Color get panelBackground => const Color.fromARGB(255, 213, 213, 213);

  @override
  Color get pokemonDetailsTitleColor => const Color(0xFFFFFFFF);

  @override
  Color get appBarButtons => const Color(0xFF000000);

  @override
  Color get primaryColor => Colors.blue.shade600;
}
