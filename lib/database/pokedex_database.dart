import 'package:sqflite/sqflite.dart';
import '../models/pokemon.dart';

// Permet de gérer la base de données
class PokedexDatabase {
  static Database? database;
  static Future<void> initDatabase() async {
    database = await openDatabase(
      "pokedex.db", // Nom de la base de données
      version: 1, // Version de la base de données, permet de gérer les migrations
      onCreate: (db, version) async { // Fonction qui sera appelée lors de la création de la base de données
        // Création de la table pokemon avec les colonnes id, name, type1 et type2
        await db.execute("CREATE TABLE IF NOT EXISTS pokemon (id INTEGER PRIMARY KEY NOT NULL, name TEXT NOT NULL, type1 TEXT NOT NULL, type2 TEXT)");
      },
    );
  }

  // Méthode qui permet de récupérer la base de données
  static Future<Database> getDatabase() async {
    if (database == null) {
      await initDatabase(); // On initialise la base de données si elle n'est pas encore initialisée
    }
    return database!;
  }

  // Méthode qui permet d'insérer un Pokémon dans la base de données
  static Future<void> insertPokemon(Pokemon pokemon) async {
    Database database = await getDatabase();
    await database.insert("pokemon", pokemon.toJson());
  }

  // Méthode qui permet de récupérer la liste des pokémons dans la base de données
  static Future<List<Pokemon>> getPokemonList() async {
    Database database = await getDatabase();
    var response = await database.query("pokemon");
    return response.map((pokemon) => Pokemon.fromJson(pokemon)).toList();
  }

  // Méthode qui permet de supprimer un Pokémon de la base de données
  static Future<void> deletePokemon(int id) async {
    Database database = await getDatabase();
    await database.delete("pokemon", where: "id = ?", whereArgs: [id]);
  }

  // Méthode qui permet de supprimer tous les pokémons de la base de données
  static Future<void> deleteAllPokemon() async {
    Database database = await getDatabase();
    await database.delete("pokemon");
  }

  // Méthode qui permet de mettre à jour un Pokémon dans la base de données
  static Future<void> updatePokemon(Pokemon pokemon) async {
    Database database = await getDatabase();
    await database.update("pokemon", pokemon.toJson(), where: "id = ?", whereArgs: [pokemon.id]);
  }

  // Méthode qui permet de récupérer un Pokémon dans la base de données à partir de son ID
  static Future<Pokemon?> getPokemon(int id) async {
    Database database = await getDatabase();
    List<Map<String, dynamic>> pokemonList = await database.query("pokemon", where: "id = ?", whereArgs: [id]);
    if (pokemonList.isEmpty) {
      return null;
    }
    return Pokemon.fromJson(pokemonList.first);
  }
}