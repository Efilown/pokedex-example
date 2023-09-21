import 'package:flutter/material.dart';
import '../models/pokemon.dart';

// Widget qui permet d'afficher un pokémon
// Elle prend en paramètre un pokémon
// Elle affiche l'image du pokémon, son nom et son numéro
// Elle permet également de naviguer vers la page de détail du pokémon
class PokemonTile extends StatefulWidget {
  const PokemonTile(this.pokemon, {Key? key}) : super(key: key);

  final Pokemon pokemon;

  @override
  State<PokemonTile> createState() => _PokemonTileState();
}

class _PokemonTileState extends State<PokemonTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Lorsqu'on tap sur le widget, on navigue vers la page de détail du pokémon
        // On utilise la méthode Navigator.pushNamed pour naviguer vers la page de détail
        // On passe en paramètre du Navigator le contexte et la route de la page de détail
        // on utilise "widget.pokemon" pour accéder au pokémon passé en paramètre; widget représente l'instance de la classe PokemonTile
        Navigator.pushNamed(context, "/pokemon-detail", arguments: widget.pokemon);
      },
      child: Container(
        height: 150,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Image.network(widget.pokemon.imageUrl, height: 100),
              Text(widget.pokemon.formatedName, 
                style: const TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 16
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}