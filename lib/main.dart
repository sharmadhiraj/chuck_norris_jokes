import 'package:chuck_norris_jokes/screens/home.dart';
import 'package:chuck_norris_jokes/util/data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChuckNorrisJokesApp());
}

class ChuckNorrisJokesApp extends MaterialApp {
  const ChuckNorrisJokesApp({super.key});

  @override
  String get title => appName;

  @override
  ThemeData get theme => ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      );

  @override
  Widget get home => HomePage();
}
