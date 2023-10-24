import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(

        appBar: AppBar(
          title:
          const Text('Strawberry Recipe'),
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Image.asset('image/strawberry.jpg'),
            Padding(padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(padding: EdgeInsets.all(10.0),
                    child: Container(
                    alignment: Alignment.center,
                    color: Colors.blue,
                    child: Text("Strawberry Pavlova"),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10.0),
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.blue,
                      child: Text("Descripcion"),
                    ),
                  ),
                ],
              ),
            )

          ],
        ),

      ),
    );
  }
}
