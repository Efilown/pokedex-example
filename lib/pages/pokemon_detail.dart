import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../components/pokemon_type.dart';

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({Key? key}) : super(key: key);

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  bool _isShiny = false;

  @override
  Widget build(BuildContext context) {
    final Pokemon pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Image.network(_isShiny ? pokemon.shinyImageUrl : pokemon.imageUrl, width: 200),
              onTap:() {
                setState(() {
                  _isShiny = !_isShiny;
                });
              },
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: pokemon.formatedName,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: " #${pokemon.id.toString().padLeft(3, "0")}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,              
              children: [
                PokemonTypeWidget(pokemon.type1),
                pokemon.type2 != null ? PokemonTypeWidget(pokemon.type2!) : Container(),
              ],
            )
          ]
        )
      ),
    );
  }
}