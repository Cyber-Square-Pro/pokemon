class ApiConstants {
  ApiConstants._();
  static String get pokedexSummaryData =>
      "https://pokedex.alansantos.dev/api/pokemons.json";

  static String pokemonDetails(String number) =>
      "https://pokedex.alansantos.dev/api/pokemons/$number.json";

  static String get pokemonItems =>
      "https://pokedex.alansantos.dev/api/items.json";

  static const String _cyclic = 'https://pokedex-teamb.cyclic.app';
  static const String _render = 'https://pokedex-team-b-flutter.onrender.com';

  static const String _localURL =
      'https://bd26-2405-201-f00c-3016-3897-543-21b4-b35a.ngrok-free.app';

  // Base URL
  static String baseURL = _render;
}
