import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../components/pokemon_tile.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Platform is not supported on web

// Page de la liste des pokémons. Elle est appelée par la route "/". Elle affiche la liste des 151 premiers pokémons.
// Elle hérite de la classe StatefulWidget car elle a besoin de gérer un état (la liste des pokémons).
class PokemonListPage extends StatefulWidget {
  const PokemonListPage({Key? key}) : super(key: key);

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {

  Widget _buildPokemonTile(BuildContext context, int index) {
    // On utilise un FutureBuilder pour afficher un pokémon à partir de son ID. L'index commençant à 0, on ajoute 1 pour le numéro du pokémon.
    // Le FutureBuilder va permettre d'afficher un widget en fonction de l'état du Future
    // Le FutureBuilder prend en paramètre un Future (ici Pokemon.fromID(index + 1))
    // Il prend aussi en paramètre une fonction qui va permettre de construire le widget en fonction de l'état du Future : builder: (context, snapshot) {}
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Si le Future a réussi à récupérer les données, on affiche le widget PokemonTile
          if (snapshot.data == null) {
            return Text('Error while fetching pokemon #${index + 1}');
          }
          return PokemonTile(snapshot.data as Pokemon);
        } else if (snapshot.hasError) {
          // Si le Future a échoué à récupérer les données, on affiche un message d'erreur
          print(snapshot.error);
          return const Text('Erreur : ');
        } else {
          // Si le Future n'a pas encore récupéré les données, on affiche un widget de chargement
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const CircularProgressIndicator(),
          );
        }
      },
      future: Pokemon.fromID(index + 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des pokémons'),
      ),
      body: Center(
        child: GridView.builder(
          // Le GridView permet d'afficher une liste de widgets sous forme de grille
          // On utilise le constructeur GridView.builder pour construire la grille
          // Le GridView.builder prend en paramètre un itemCount qui correspond au nombre d'éléments à afficher
          // Il prend aussi en paramètre un itemBuilder qui va permettre de construire chaque élément de la grille
          // Le GridView.builder prend aussi en paramètre un gridDelegate qui va permettre de définir le nombre de colonnes de la grille
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: kIsWeb ? 4 : 2, // On affiche 4 colonnes sur le web et 2 colonnes sur mobile
          ),
          itemCount: 151, // On pourrait en mettre plus mais on va se limiter aux 151 premiers pokémons
          itemBuilder: _buildPokemonTile,
        )
      ),
    );
  }
}