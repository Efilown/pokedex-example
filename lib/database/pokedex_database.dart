import 'package:sqflite/sqflite.dart';
import '../models/pokemon.dart';

class PokedexDatabase {
  static Database? database;
  static Future<void> initDatabase() async {
    database = await openDatabase(
      "pokedex.db",
      version: 1,
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE IF NOT EXISTS pokemon (id INTEGER PRIMARY KEY NOT NULL, name TEXT NOT NULL, type1 TEXT NOT NULL, type2 TEXT)");
      },
    );
  }

  static Future<Database> getDatabase() async {
    if (database == null) {
      await initDatabase();
    }
    return database!;
  }

  static Future<void> insertPokemon(Pokemon pokemon) async {
    Database database = await getDatabase();
    await database.insert("pokemon", pokemon.toJson());
  }

  static Future<List<Pokemon>> getPokemonList() async {
    Database database = await getDatabase();
    var response = await database.query("pokemon");
    return response.map((pokemon) => Pokemon.fromJson(pokemon)).toList();
  }

  static Future<void> deletePokemon(int id) async {
    Database database = await getDatabase();
    await database.delete("pokemon", where: "id = ?", whereArgs: [id]);
  }

  static Future<void> deleteAllPokemon() async {
    Database database = await getDatabase();
    await database.delete("pokemon");
  }

  static Future<void> updatePokemon(Pokemon pokemon) async {
    Database database = await getDatabase();
    await database.update("pokemon", pokemon.toJson(), where: "id = ?", whereArgs: [pokemon.id]);
  }

  static Future<Pokemon?> getPokemon(int id) async {
    Database database = await getDatabase();
    List<Map<String, dynamic>> pokemonList = await database.query("pokemon", where: "id = ?", whereArgs: [id]);
    if (pokemonList.isEmpty) {
      return null;
    }
    return Pokemon.fromJson(pokemonList.first);
  }
}