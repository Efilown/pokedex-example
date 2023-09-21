import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../utils/pokemon_type.dart';

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
        border: typeColor == Colors.white ? Border.all(color: Colors.black) : null,
      ),
      child: SizedBox(
        width: 60,
        child: Text(typeName, style: TextStyle(color: (typeColor == Colors.white) ? Colors.black : Colors.white), textAlign: TextAlign.center)
      ),
    );
  }
}