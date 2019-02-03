class Pokemon {

  final List abilities;
  final List moves;
  final List stats;
  final List types;
  final int baseExperience;
  final double weight;
  final double height;

  Pokemon({ this.abilities, this.baseExperience, this.moves, this.stats, this.types, this.weight, this.height });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon (
      abilities: json['abilities'] as List,
      baseExperience: json['base_experience'] as int,
      moves: json['moves'] as List,
      stats: json['stats'] as List,
      types: json['types'] as List,
      weight: json['weight'] * 0.1, //kg
      height: json['height'] * 0.1, // m
    );
  }
}

class PokemonSpecies {

  final String color;
  final String genus;
  final String flavorText;
  final int captureRate;

  PokemonSpecies({ this.color, this.genus, this.flavorText, this.captureRate });

  factory PokemonSpecies.fromJson(Map<String, dynamic> json) {

    return PokemonSpecies (
      color: json['color']['name'] as String,
      genus: json['genera'][2]['genus'] as String,
      flavorText: json['flavor_text_entries'].toList().firstWhere((text) => text['language']['name'] == 'en', orElse: () => ' ')['flavor_text'].replaceAll('\n', ' '),
      captureRate: json['capture_rate'],
    );
  }
}

class PokemonMerged {
  final Pokemon pokemon;
  final PokemonSpecies pokemonSpecies;

  PokemonMerged({this.pokemon, this.pokemonSpecies});
}