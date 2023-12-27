import 'package:flutter/material.dart';
import 'package:app/theme/light/app_colors_light.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dark/app_colors_dark.dart';

abstract class AppColors {
  const AppColors();

  Color get panelBackground;
  Color get pokeballLogoBlack;
  Color get pokeballLogoGray;
  Color get pokemonDetailsTitleColor;
  Color get appBarButtons;

  Color get floatActionButton => const Color(0xFF6C79DB);

  Color get selectPokemonTabTitle;
  Color get pokemonTabTitle;
  Color get tabDivisor => const Color(0xFFE4E4E4);
  Color get tabIndicator => const Color(0xFF6C79DB);

  Color get marsIcon => const Color(0xFF919BE4);
  Color get venusIcon => const Color(0xFFF38EB3);

  Color get unknownIcon => const Color(0xFF303943);

  Color get generationFilter;
  Color get selectedGenerationFilter;

  Color get drawerAbilities => const Color(0xFF59ABF6);
  Color get drawerItems => const Color(0xFFFFCE4B);
  Color get drawerLocations => const Color(0xFF7C538C);
  Color get drawerMoves => const Color(0xFFFF8D82);
  Color get drawerPokedex => const Color(0xFF50C1A6);
  Color get drawerTypeCharts => const Color(0xFFB1736C);
  Color get drawerDisabled => const Color(0xFF999999);

  Color baseStatsBar(double percentage) {
    if (percentage < 0.1666) {
      return const Color(0xFFF34544);
    } else if (percentage < 0.3332) {
      return const Color(0xFFFF7F0F);
    } else if (percentage < 0.4998) {
      return const Color(0xFFFFDD57);
    } else if (percentage < 0.6664) {
      return const Color(0xFFA1E515);
    } else if (percentage < 0.833) {
      return const Color(0xFF22CD5E);
    } else {
      return const Color(0xFF00C2B7);
    }
  }

  Color pokemonItem(String type) {
    switch (type) {
      case 'Normal':
        return const Color(0xFFA7A877);
      case 'Fire':
        return const Color(0xFFFB6C6C);
      case 'Water':
        return const Color(0xFF77BDFE);
      case 'Grass':
        return const Color(0xFF48D0B0);
      case 'Electric':
        return const Color(0xFFFFCE4B);
      case 'Ice':
        return const Color(0xFF99D7D8);
      case 'Fighting':
        return const Color(0xFFC03128);
      case 'Poison':
        return const Color(0xFF9F419F);
      case 'Ground':
        return const Color(0xFFE1C068);
      case 'Flying':
        return const Color(0xFFA890F0);
      case 'Psychic':
        return const Color(0xFFF95887);
      case 'Bug':
        return const Color(0xFFA8B91F);
      case 'Rock':
        return const Color(0xFFB8A038);
      case 'Ghost':
        return const Color(0xFF705998);
      case 'Dark':
        return const Color(0xFF6F5848);
      case 'Dragon':
        return const Color(0xFF7138F8);
      case 'Steel':
        return const Color(0xFFB8B8D0);
      case 'Fairy':
        return const Color(0xFFA890F0);
      default:
        return Colors.grey;
    }
  }
}

class AppTheme {
  static AppColors get colors => const AppColorsLight();

  static AppColors getColors(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? const AppColorsLight()
        : const AppColorsDark();
  }

  static double get globalBorderRadius => 15.r;
  static EdgeInsetsGeometry get pagePadding => EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 10.h,
      );
}

final Color mediumBlue = Colors.blue.shade600;
