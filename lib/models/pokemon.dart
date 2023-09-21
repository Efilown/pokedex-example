import 'package:flutter/foundation.dart' show kIsWeb; // Platform is not supported on web
import '../database/pokedex_database.dart';
import '../api/pokemon_api.dart';
import '../utils/pokemon_type.dart';
import 'package:flutter/material.dart';

class Pokemon {
  String name;
  int id;
  PokemonType type1;
  PokemonType? type2;

  String get imageUrl => 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  String get shinyImageUrl => 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/$id.png';
  String get cryUrl => 'https://pokemoncries.com/cries/$id.mp3';

  String get formatedName {
    return name[0].toUpperCase() + name.substring(1);
  }
  Color get type1Color => typeToColor(type1);
  Color get type2Color => typeToColor(type2 ?? PokemonType.unknown);
  String get type1Formated => formatedTypeName(type1);
  String get type2Formated => formatedTypeName(type2 ?? PokemonType.unknown);

  Pokemon({
    required this.name,
    required this.id,
    required this.type1,
    this.type2,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      id: json['id'],
      // Parcours des valeurs de l'enum PokemonType et récupération de la première valeur qui correspond à la string 'PokemonType.${json['type1']}'
      type1: PokemonType.values.firstWhere((element) => element.toString() == 'PokemonType.${json['type1']}'), 
      type2: json['type2'] != null ? PokemonType.values.firstWhere((element) => element.toString() == 'PokemonType.${json['type2']}') : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'type1': type1.toString().split('.').last, // On récupère la valeur de l'enum PokemonType sans le préfixe 'PokemonType.'
      'type2': type2?.toString().split('.').last,
    };
  }

  static Future<Pokemon?> fromID(int id) async {
    Pokemon? pokemon;
    if (!kIsWeb) {
      pokemon = await PokedexDatabase.getPokemon(id);
    }
    if (pokemon == null) {
      try {
        pokemon = await PokemonApi.getPokemon(id);
        if (!kIsWeb) {
          await PokedexDatabase.insertPokemon(pokemon);
        }
      } catch (e) {
        print(e);
        return null;
      }
    }
    return pokemon;
  }

}

enum PokemonType {
  normal, fighting, flying, poison, ground, rock, bug, ghost, steel, fire, water, grass, electric, psychic, ice, dragon, dark, fairy, unknown, shadow
}