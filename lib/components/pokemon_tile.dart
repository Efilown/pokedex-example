import 'package:flutter/material.dart';
import '../models/pokemon.dart';


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