import 'package:chuck_norris_jokes/util/data.dart';
import 'package:chuck_norris_jokes/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends MaterialApp {
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
