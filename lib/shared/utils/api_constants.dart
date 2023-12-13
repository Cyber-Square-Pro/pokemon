class ApiConstants {
  static String get pokedexSummaryData => "https://pokedex.alansantos.dev/api/pokemons.json";

  static String pokemonDetails(String number) => "https://pokedex.alansantos.dev/api/pokemons/$number.json";

  static String get pokemonItems => "https://pokedex.alansantos.dev/api/items.json";

  // DEPLOYED TO CYCLIC.SH
  static String baseURL = 'https://pokedex-teamb.cyclic.app';
}
