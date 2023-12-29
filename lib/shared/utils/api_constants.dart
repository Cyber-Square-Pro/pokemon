class ApiConstants {
  ApiConstants._();
  static String get pokedexSummaryData =>
      "https://pokedex.alansantos.dev/api/pokemons.json";

  static String pokemonDetails(String number) =>
      "https://pokedex.alansantos.dev/api/pokemons/$number.json";

  static String get pokemonItems =>
      "https://pokedex.alansantos.dev/api/items.json";

  // static const String _deployedURL = 'https://pokedex-teamb.cyclic.app';
  static const String _localURL =
      'https://79cc-2405-201-f00c-3016-2c25-261a-12e2-c69f.ngrok-free.app';

  // Base URL
  static String baseURL = _localURL;
}
