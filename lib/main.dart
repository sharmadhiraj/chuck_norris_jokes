import 'package:chuck_norris_jokes/data.dart';
import 'package:chuck_norris_jokes/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends MaterialApp {
  @override
  String get title => appName;

  @override
  ThemeData get theme => ThemeData(primarySwatch: Colors.blue);

  @override
  Widget get home => HomePage();
}
