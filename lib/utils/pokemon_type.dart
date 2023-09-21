import 'package:flutter/material.dart';
import '../models/pokemon.dart';

Color typeToColor(PokemonType type) {
  Map<PokemonType, Color> typeToColor = {
    PokemonType.normal: Colors.white,
    PokemonType.fire: Colors.red,
    PokemonType.water: Colors.blue,
    PokemonType.electric: Colors.yellow,
    PokemonType.grass: Colors.green,
    PokemonType.ice: Colors.cyan,
    PokemonType.fighting: Colors.orange,
    PokemonType.poison: Colors.purple,
    PokemonType.ground: Colors.brown,
    PokemonType.flying: Colors.indigo,
    PokemonType.psychic: Colors.pink,
    PokemonType.bug: Colors.lightGreen,
    PokemonType.rock: Colors.grey,
    PokemonType.ghost: Colors.indigo,
    PokemonType.dragon: Colors.indigo,
    PokemonType.dark: Colors.black45,
    PokemonType.steel: Colors.grey.shade600,
    PokemonType.fairy: Colors.pinkAccent,
    PokemonType.unknown: Colors.transparent,
    PokemonType.shadow: Colors.transparent,
  };
  return typeToColor[type] ?? Colors.transparent;
}

String formatedTypeName(PokemonType type) {
  String typeName = type.toString().split('.').last.replaceAll('PokemonType.', '');
  return typeName[0].toUpperCase() + typeName.substring(1);
}