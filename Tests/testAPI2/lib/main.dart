import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(PokedexApp());
}

class PokedexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PokedexScreen(),
    );
  }
}

class PokedexScreen extends StatefulWidget {
  @override
  _PokedexScreenState createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  final String apiUrl = "https://pokeapi.co/api/v2/pokemon?limit=1000"; // Reducido para fines de demostración
  List<Pokemon> pokemons = [];

  @override
  void initState() {
    super.initState();
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> results = data['results'];
      List<Pokemon> tempPokemons = [];
      for (var item in results) {
        final name = item['name'];
        final url = item['url'];
        final pokemonId = int.parse(url.split('/')[6]);
        tempPokemons.add(Pokemon(name, pokemonId));
      }
      setState(() {
        pokemons = tempPokemons;
      });
    } else {
      throw Exception('Failed to load pokemons');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokédex'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          return GridTile(
            child: Card(
              elevation: 4,
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemons[index].id}.png',
                    placeholder: (context, url) => SizedBox(
                      width: 40,
                      height: 40,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${pokemons[index].id} ${pokemons[index].name}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Puedes agregar detalles adicionales del Pokémon debajo del nombre si lo deseas.
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Pokemon {
  final String name;
  final int id;

  Pokemon(this.name, this.id);
}