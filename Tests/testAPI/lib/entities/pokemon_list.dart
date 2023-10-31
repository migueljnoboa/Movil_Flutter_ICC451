import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class PokemonList{
  final int count;
  final String? next;
  final String? previous;

  const PokemonList({
    required this.count,
    required this.next,
    required this.previous,
});

  factory PokemonList.fromJson(Map<String, dynamic> json){
    return PokemonList(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
    );
  }

}

Future<PokemonList> fetchPokemonList(String url) async{

  url ??= 'https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20';
  final response = await http.get(Uri.parse(url));

  // if Its successful
  if (response.statusCode == 200) {

    PokemonList pokemonList = PokemonList.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

    return pokemonList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
  
}