import 'package:flutter/foundation.dart' show kIsWeb; // Platform is not supported on web
import '../database/pokedex_database.dart';
import '../api/pokemon_api.dart';
import '../utils/pokemon_type.dart';
import 'package:flutter/material.dart';

// Classe représentant un Pokémon. Elle contient le nom, le numéro et les types du Pokémon.
// Elle contient aussi des propriétés calculées pour récupérer l'url de l'image du Pokémon, l'url de l'image shiny du Pokémon et l'url du cri du Pokémon.
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
    this.type2, // Le type 2 n'est pas toujours présent
  });

  // Constructeur qui permet de créer un Pokémon à partir d'un fichier JSON récupéré depuis l'API.
  // Sera aussi utilisé pour la récupération depuis la base de données
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      id: json['id'],
      // Parcours des valeurs de l'enum PokemonType et récupération de la première valeur qui correspond à la string 'PokemonType.${json['type1']}'
      type1: PokemonType.values.firstWhere((element) => element.toString() == 'PokemonType.${json['type1']}'), 
      type2: json['type2'] != null ? PokemonType.values.firstWhere((element) => element.toString() == 'PokemonType.${json['type2']}') : null,
    );
  }

  // Méthode qui permet de convertir un Pokémon en fichier JSON. Sera aussi utilisé pour l'insertion dans la base de données
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'type1': type1.toString().split('.').last, // On récupère la valeur de l'enum PokemonType sans le préfixe 'PokemonType.'
      'type2': type2?.toString().split('.').last,
    };
  }

  // Méthode qui permet de récupérer un Pokémon à partir de son ID
  // Si le Pokémon n'est pas présent dans la base de données, on le récupère depuis l'API
  static Future<Pokemon?> fromID(int id) async {
    Pokemon? pokemon;
    if (!kIsWeb) {
      // La base de données n'est pas disponible sur le web
      pokemon = await PokedexDatabase.getPokemon(id);
    }
    if (pokemon == null) {
      try {
        pokemon = await PokemonApi.getPokemon(id);
        if (!kIsWeb) {
          // On insère le Pokémon dans la base de données
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

// Enum qui représente les différents types de Pokémon
enum PokemonType {
  normal, fighting, flying, poison, ground, rock, bug, ghost, steel, fire, water, grass, electric, psychic, ice, dragon, dark, fairy, unknown, shadow
}