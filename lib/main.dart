import 'package:flutter/material.dart';
import 'pages/pokemon_list.dart';
import 'pages/pokemon_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon super Pokédex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // home a été enlevé pour être remplacé par la route "/"
      routes: {
        '/': (context) => const PokemonListPage(),
        '/pokemon-detail':(context) => const PokemonDetailPage(),
      }
    );
  }
}

