

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords()
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {

  final _suggestion = <WordPair>[];
  final _biggestFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
      ),
      body: _buildSuggestion(),
    );
  }

  Widget _buildSuggestion(){
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i){
          if (i.isOdd) return Divider();

          final index = i~/2;
          if (index >= _suggestion.length){
            _suggestion.addAll(generateWordPairs().take(10));
          }

          return _buildRown(_suggestion[index]);

        });
  }

  Widget _buildRown(WordPair pair){
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggestFont,
      ),
    );
  }
}
