# pokedex

Projet d'exemple d'application Flutter pour les cours de bootcamp Ynov 2023.
Ce projet contient un début de pokédex, une application listant des pokémons et permettant d'en voir les détails.

## Installation

```
git clone https://github.com/Efilown/pokedex-example.git
cd pokedex-example
flutter pub get
```

Ensuite, ouvrir le projet avec un IDE (tel que vscode) et le lancer sur le device de votre choix (téléphone, émulateur ou navigateur).

## Ressources utilisées 

Pour les images (remplacer par l'id du pokémon désiré): 
- [Sprite normal](https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png)
- [Sprite shiny](https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/6.png)

Autres liens
- [l'API pour récupérer les informations](https://pokeapi.co/api/v2/pokemon/6)
- [Les cris de bataille](https://pokemoncries.com/cries/1.mp3)
- [La documentation du paquet SQFlite](https://pub.dev/packages/sqflite)
- [La documentation du paquet HTTP](https://pub.dev/packages/http)


## Améliorations possible

- Mettre un lecteur audio pour écouter les cris des pokémons
- Rajouter la traduction (en fonction de la langue de l'application ? ☺)
- Compléter la vue détail avec des informations tirées de l'API
- Faire une vue "mon équipe" contenant 6 pokémons choisis en rajoutant un bouton "ajouter à mon équipe" sur la vue détail.

Amusez-vous !