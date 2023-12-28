import 'package:flutter/material.dart';

import '../app_theme.dart';

class AppColorsDark extends AppColors {
  const AppColorsDark();

  @override
  Color get pokemonTabTitle => const Color(0xFF303943).withOpacity(0.4);

  @override
  Color get selectPokemonTabTitle => const Color(0xFF303943);

  @override
  Color get selectedGenerationFilter =>
      const Color(0xFFFFFFFF).withOpacity(0.5);

  @override
  Color get pokeballLogoBlack => const Color(0xFFD8D8D8);

  @override
  Color get pokeballLogoGray => const Color(0xFFFFFFFF).withOpacity(0.2);

  @override
  Color get generationFilter => const Color(0xFF121212);

  @override
  Color get panelBackground => const Color(0xFF000000);

  @override
  Color get pokemonDetailsTitleColor => const Color(0xFF121212);

  @override
  Color get appBarButtons => const Color(0xFFFFFFFF);

  // UI Components
  @override
  Color get primaryColor => Colors.blue.shade800;
}
