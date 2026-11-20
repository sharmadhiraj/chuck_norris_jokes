import 'package:chuck_norris_jokes/features/jokes/jokes_screen.dart';
import 'package:chuck_norris_jokes/data/favorite_jokes_store.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavoriteJokesStore.instance.load();
  runApp(const ChuckNorrisJokesApp());
}

class ChuckNorrisJokesApp extends StatelessWidget {
  const ChuckNorrisJokesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chuck Norris Jokes",
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      home: const JokesScreen(),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    return ThemeData(
      colorSchemeSeed: Colors.deepOrange,
      brightness: brightness,
    );
  }
}
