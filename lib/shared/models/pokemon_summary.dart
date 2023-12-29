import 'package:app/shared/models/pokemon.dart';
import 'package:equatable/equatable.dart';

class PokemonSummary extends Equatable {
  late final String number;
  late final String name;
  late final String imageUrl;
  late final String thumbnailUrl;
  late final Sprites sprites;
  late final List<String> types;
  late final String specie;
  late final Generation generation;

  PokemonSummary({
    required this.number,
    required this.name,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.sprites,
    required this.types,
    required this.specie,
    required this.generation,
  });

  factory PokemonSummary.fromJson(Map<String, dynamic> json) => PokemonSummary(
        number: json['number'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        thumbnailUrl: json['thumbnailUrl'],
        sprites: Sprites.fromJson(json['sprites']),
        types: json['types'].cast<String>(),
        specie: json['specie'],
        generation: Generation.values
            .where((it) => it.toString().endsWith(json['generation']))
            .first,
      );

  // PokemonSummary.fromJson(Map<String, dynamic> json) {
  //   number = json['number'];
  //   name = json['name'];
  //   imageUrl = json['imageUrl'];
  //   thumbnailUrl = json['thumbnailUrl'];
  //   sprites = Sprites.fromJson(json['sprites']);
  //   types = json['types'].cast<String>();
  //   specie = json['specie'];
  //   generation = Generation.values
  //       .where((it) => it.toString().endsWith(json['generation']))
  //       .first;
  // }

  @override
  List<Object?> get props => [number, name];
}
