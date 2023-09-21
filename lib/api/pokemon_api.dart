import '../models/pokemon.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Classe qui permet de récupérer les données des pokémons depuis l'API
// On utilise la librairie http pour effectuer les requêtes
// On utilise la librairie dart:convert pour convertir les données JSON en objet Dart
class PokemonApi {
  static const String baseUrl = 'pokeapi.co';
  static const String pokemonUrl = 'api/v2/pokemon';

  static Future<Pokemon> getPokemon(int id) async {
    // On utilise la méthode get de la classe http pour effectuer une requête GET
    // On utilise Uri.https pour construire l'URL de la requête
    // URI.https prends en paramètre le nom de domaine et le chemin de la requête
    var response = await http.get(Uri.https(baseUrl, "$pokemonUrl/$id"));
    if (response.statusCode != 200) {
      // Si le code de retour de la requête n'est pas 200, on lève une exception
      throw Exception('Erreur lors de la récupération du pokémon $id, code de retour ${response.statusCode}');
    }
    // On utilise la méthode jsonDecode de la librairie dart:convert pour convertir le corps de la réponse en fichier JSON
    var json = jsonDecode(response.body);
    String name = json['name'];
    String type1 = (json['types'].length > 0 && json['types'][0]['type'] != null && json['types'][0]['type']['name'] != null) ? json['types'][0]['type']['name'] : "unknown";
    String? type2 = (json['types'].length > 1 && json['types'][1]['type'] != null && json['types'][1]['type']['name'] != null) ? json['types'][1]['type']['name'] : null;
    // On crée un objet Pokemon à partir du fichier JSON
    return Pokemon(
      name: name, 
      id: id, 
      type1: PokemonType.values.firstWhere((element) => element.toString() == 'PokemonType.$type1'),
      type2: type2 != null ? PokemonType.values.firstWhere((element) => element.toString() == 'PokemonType.$type2') : null,
    );
  }
}