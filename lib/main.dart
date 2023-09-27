import 'package:flutter/material.dart';
import './src/home.dart';
import './src/home2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navegacion secundaria'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navegar a la segunda pantalla cuando se presiona el botón
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TabBarDemo()),
            );
          },
          child: Text('Ir a la Segunda Pantalla'),
        ),
      ),
    );
  }
}

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Text(
                  "Buscar albums",
                ),
                Text("Buscar cancion"),
              ],
            ),
            title: const Text('Buscador'),
          ),
          body: const TabBarView(
            children: [MyHomePage(), Home2()],
          ),
        ),
      ),
    );
  }
}
