import 'package:flutter/material.dart';
import 'pages/pokemon_list.dart';
import 'pages/pokemon_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon super Pokédex', // Titre de l'application
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false, // Permet de masquer la bannière "Debug"
      // home a été enlevé pour être remplacé par la route "/"
      routes: {
        '/': (context) => const PokemonListPage(), // La route "/" est la page d'accueil
        '/pokemon-detail':(context) => const PokemonDetailPage(),
      }
    );
  }
}

