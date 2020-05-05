import 'package:flutter_web/material.dart';

import 'data.dart';
import 'home.dart';

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
