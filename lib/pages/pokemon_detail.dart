import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../components/pokemon_type.dart';

// Vue détail d'un Pokémon. Elle est appelée par la route "/pokemon-detail". Elle prend en paramètre un Pokémon.
// Elle affiche l'image du Pokémon, son nom, son numéro et ses types. Elle permet également de passer en mode shiny.
// Elle hérite de la classe StatefulWidget car elle a besoin de gérer un état (le mode shiny).
class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({Key? key}) : super(key: key);

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

// La classe _PokemonDetailPageState hérite de la classe State. Elle permet de gérer l'état de la page.
// Elle contient une variable _isShiny qui permet de savoir si le mode shiny est activé ou non.
class _PokemonDetailPageState extends State<PokemonDetailPage> {
  // Variable qui permet de savoir si le mode shiny est activé ou non
  bool _isShiny = false;

  @override
  Widget build(BuildContext context) {
    // On récupère le Pokémon passé en paramètre de la route
    final Pokemon pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Le GestureDetector va permettre de détecter un tap sur l'image du Pokémon
            GestureDetector(
              // L'image du Pokémon est une image en ligne. On utilise donc Image.network
              // On utilise la variable _isShiny pour savoir si on affiche l'image normale ou l'image shiny
              child: Image.network(_isShiny ? pokemon.shinyImageUrl : pokemon.imageUrl, width: 200),
              onTap:() {
                // Lorsqu'on tap sur l'image, on change la valeur de la variable _isShiny
                // Cela va permettre de changer l'image affichée
                // On utilise la méthode setState pour dire à Flutter que la valeur de la variable a changé
                setState(() {
                  _isShiny = !_isShiny;
                });
              },
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: pokemon.formatedName, // formatedName est une propriété calculée du modèle Pokemon
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: " #${pokemon.id.toString().padLeft(4, "0")}",
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