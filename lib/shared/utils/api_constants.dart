class ApiConstants {
  static String get pokedexSummaryData => "https://pokedex.alansantos.dev/api/pokemons.json";

  static String pokemonDetails(String number) =>
      "https://pokedex.alansantos.dev/api/pokemons/$number.json";

  static String get pokemonItems => "https://pokedex.alansantos.dev/api/items.json";

  static String baseURL = 'https://18fe-2405-201-f00c-3016-d4bb-4dce-d0a3-4c26.ngrok-free.app';
}
