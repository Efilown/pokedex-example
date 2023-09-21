import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../components/pokemon_tile.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Platform is not supported on web

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({Key? key}) : super(key: key);

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {

  Widget _buildPokemonTile(BuildContext context, int index) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            return Text('Error while fetching pokemon #${index + 1}');
          }
          return PokemonTile(snapshot.data as Pokemon);
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return const Text('Erreur : ');
        } else {
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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: kIsWeb ? 4 : 2,
          ),
          itemCount: 151,
          itemBuilder: _buildPokemonTile,
        )
      ),
    );
  }
}