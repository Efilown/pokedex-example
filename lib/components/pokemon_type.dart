import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../utils/pokemon_type.dart';

// Widget qui permet d'afficher un type de Pokémon
// Elle prend en paramètre un type de Pokémon
// Elle affiche le nom du type avec une couleur de fond correspondant au type
class PokemonTypeWidget extends StatelessWidget {
  const PokemonTypeWidget(this.type, {Key? key}) : super(key: key);

  final PokemonType type;

  @override
  Widget build(BuildContext context) {
    String typeName = formatedTypeName(type);
    Color typeColor = typeToColor(type);

    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(right: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: typeColor,
        borderRadius: BorderRadius.circular(10),
        // On rajoute une bordure noire si le fond est blanc
        border: typeColor == Colors.white ? Border.all(color: Colors.black) : null,
      ),
      child: SizedBox(
        width: 60,
        // Discriminant pour définir la couleur du texte en fonction de la couleur de fond
        child: Text(typeName, style: TextStyle(color: (typeColor == Colors.white) ? Colors.black : Colors.white), textAlign: TextAlign.center)
      ),
    );
  }
}