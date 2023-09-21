import '../models/pokemon.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonApi {
  static const String baseUrl = 'pokeapi.co';
  static const String pokemonUrl = 'api/v2/pokemon';

  static Future<Pokemon> getPokemon(int id) async {
    var response = await http.get(Uri.https(baseUrl, "$pokemonUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la récupération du pokémon $id, code de retour ${response.statusCode}');
    }
    var json = jsonDecode(response.body);
    String name = json['name'];
    String type1 = (json['types'].length > 0 && json['types'][0]['type'] != null && json['types'][0]['type']['name'] != null) ? json['types'][0]['type']['name'] : "unknown";
    String? type2 = (json['types'].length > 1 && json['types'][1]['type'] != null && json['types'][1]['type']['name'] != null) ? json['types'][1]['type']['name'] : null;
    return Pokemon(
      name: name, 
      id: id, 
      type1: PokemonType.values.firstWhere((element) => element.toString() == 'PokemonType.$type1'),
      type2: type2 != null ? PokemonType.values.firstWhere((element) => element.toString() == 'PokemonType.$type2') : null,
    );
  }
}