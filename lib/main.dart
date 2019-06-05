import 'package:flutter_web/material.dart';

void main() => runApp(App());

class App extends MaterialApp {
  @override
  String get title => "Chuck Norris Jokes";
  @override
  ThemeData get theme => ThemeData(primarySwatch: Colors.blue);
  @override
  Widget get home => HomePage();
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chuck Norris Jokes")),
      body: Center(child:Text("Chuck Norris Jokes")),
    );
  }
}
