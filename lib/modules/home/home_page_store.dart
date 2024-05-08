// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'home_page_store.g.dart';

class HomePageStore = _PokemonGridStoreBase with _$HomePageStore;

enum PanelType {
  filterPokemonGeneration,
  filterPokemonType,
  filterPokemonNameNumber,
  filterItems,
  favouritesPokemons
}

extension PanelTypeExtension on PanelType {
  bool get isTextFilter {
    return this == PanelType.filterPokemonNameNumber ||
        this == PanelType.filterItems;
  }
}

enum HomePageType {
  pokemonGrid,
  items,
  favourites,
  news,
  videos,
  checkIn,
  merchandise,
  card
}

extension HomePageTypeExtension on HomePageType {
  String get description {
    switch (this) {
      case HomePageType.pokemonGrid:
        return "Pokemon";
      case HomePageType.items:
        return "Items";
      case HomePageType.favourites:
        return "Favourites";
      case HomePageType.news:
        return "News";
      case HomePageType.videos:
        return "Videos";
      case HomePageType.checkIn:
        return "Daily Check-In";
      case HomePageType.merchandise:
        return "Merchandise";
      default:
        throw "Home Page Type not found";
    }
  }
}

abstract class _PokemonGridStoreBase with Store {
  @observable
  bool _isFilterOpen = false;

  @observable
  bool _isBackgroundBlack = false;

  @observable
  bool _isFabVisible = true;

  @observable
  PanelType? _panelType;

  @observable
  HomePageType _page = HomePageType.pokemonGrid;

  @computed
  bool get isFilterOpen => _isFilterOpen;

  @computed
  PanelType? get panelType => _panelType;

  @computed
  bool get isBackgroundBlack => _isBackgroundBlack;

  @computed
  bool get isFabVisible => _isFabVisible;

  @computed
  HomePageType get page => _page;

  @action
  void openFilter() {
    _isFilterOpen = true;
  }

  @action
  void closeFilter() {
    _isFilterOpen = false;
    _panelType = null;
  }

  @action
  void showBackgroundBlack() {
    _isBackgroundBlack = true;
  }

  @action
  void hideBackgroundBlack() {
    _isBackgroundBlack = false;
  }

  @action
  void showFloatActionButton() {
    _isFabVisible = true;
  }

  @action
  void hideFloatActionButton() {
    _isFabVisible = false;
  }

  @action
  void setPanelType(PanelType panelType) {
    _panelType = panelType;
  }

  @action
  void setPage(HomePageType page) {
    _page = page;
  }
}
