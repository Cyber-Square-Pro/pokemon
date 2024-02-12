// To parse this JSON data, do
//
//     final pokemonSummaryList = pokemonSummaryListFromJson(jsonString);

import 'dart:convert';

List<PokemonSummaryList> pokemonSummaryListFromJson(String str) => List<PokemonSummaryList>.from(json.decode(str).map((x) => PokemonSummaryList.fromJson(x)));

String pokemonSummaryListToJson(List<PokemonSummaryList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PokemonSummaryList {
    final Sprites sprites;
    final String id;
    final String number;
    final String name;
    final String imageUrl;
    final String thumbnailUrl;
    final List<Type> types;
    final String specie;
    final Generation generation;

    PokemonSummaryList({
        required this.sprites,
        required this.id,
        required this.number,
        required this.name,
        required this.imageUrl,
        required this.thumbnailUrl,
        required this.types,
        required this.specie,
        required this.generation,
    });

    factory PokemonSummaryList.fromJson(Map<String, dynamic> json) => PokemonSummaryList(
        sprites: Sprites.fromJson(json["sprites"]),
        id: json["_id"],
        number: json["number"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        thumbnailUrl: json["thumbnailUrl"],
        types: List<Type>.from(json["types"].map((x) => typeValues.map[x]!)),
        specie: json["specie"],
        generation: generationValues.map[json["generation"]]!,
    );

    Map<String, dynamic> toJson() => {
        "sprites": sprites.toJson(),
        "_id": id,
        "number": number,
        "name": name,
        "imageUrl": imageUrl,
        "thumbnailUrl": thumbnailUrl,
        "types": List<dynamic>.from(types.map((x) => typeValues.reverse[x])),
        "specie": specie,
        "generation": generationValues.reverse[generation],
    };
}

enum Generation {
    GENERATION_I,
    GENERATION_II,
    GENERATION_III,
    GENERATION_IV,
    GENERATION_V,
    GENERATION_VI,
    GENERATION_VII,
    GENERATION_VIII
}

final generationValues = EnumValues({
    "GENERATION_I": Generation.GENERATION_I,
    "GENERATION_II": Generation.GENERATION_II,
    "GENERATION_III": Generation.GENERATION_III,
    "GENERATION_IV": Generation.GENERATION_IV,
    "GENERATION_V": Generation.GENERATION_V,
    "GENERATION_VI": Generation.GENERATION_VI,
    "GENERATION_VII": Generation.GENERATION_VII,
    "GENERATION_VIII": Generation.GENERATION_VIII
});

class Sprites {
    final String mainSpriteUrl;
    final String? frontAnimatedSpriteUrl;
    final String? backAnimatedSpriteUrl;
    final String? frontShinyAnimatedSpriteUrl;
    final String? backShinyAnimatedSpriteUrl;

    Sprites({
        required this.mainSpriteUrl,
        this.frontAnimatedSpriteUrl,
        this.backAnimatedSpriteUrl,
        this.frontShinyAnimatedSpriteUrl,
        this.backShinyAnimatedSpriteUrl,
    });

    factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
        mainSpriteUrl: json["mainSpriteUrl"],
        frontAnimatedSpriteUrl: json["frontAnimatedSpriteUrl"],
        backAnimatedSpriteUrl: json["backAnimatedSpriteUrl"],
        frontShinyAnimatedSpriteUrl: json["frontShinyAnimatedSpriteUrl"],
        backShinyAnimatedSpriteUrl: json["backShinyAnimatedSpriteUrl"],
    );

    Map<String, dynamic> toJson() => {
        "mainSpriteUrl": mainSpriteUrl,
        "frontAnimatedSpriteUrl": frontAnimatedSpriteUrl,
        "backAnimatedSpriteUrl": backAnimatedSpriteUrl,
        "frontShinyAnimatedSpriteUrl": frontShinyAnimatedSpriteUrl,
        "backShinyAnimatedSpriteUrl": backShinyAnimatedSpriteUrl,
    };
}

enum Type {
    BUG,
    DARK,
    DRAGON,
    ELECTRIC,
    FAIRY,
    FIGHTING,
    FIRE,
    FLYING,
    GHOST,
    GRASS,
    GROUND,
    ICE,
    NORMAL,
    POISON,
    PSYCHIC,
    ROCK,
    STEEL,
    WATER
}

final typeValues = EnumValues({
    "Bug": Type.BUG,
    "Dark": Type.DARK,
    "Dragon": Type.DRAGON,
    "Electric": Type.ELECTRIC,
    "Fairy": Type.FAIRY,
    "Fighting": Type.FIGHTING,
    "Fire": Type.FIRE,
    "Flying": Type.FLYING,
    "Ghost": Type.GHOST,
    "Grass": Type.GRASS,
    "Ground": Type.GROUND,
    "Ice": Type.ICE,
    "Normal": Type.NORMAL,
    "Poison": Type.POISON,
    "Psychic": Type.PSYCHIC,
    "Rock": Type.ROCK,
    "Steel": Type.STEEL,
    "Water": Type.WATER
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
