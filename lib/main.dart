import 'package:flutter_web/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
      body: FutureBuilder<String>(
        future: fetchJoke(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              return Center(
                child: Text(snapshot.hasError ? snapshot.error : snapshot.data,
                    style: TextStyle(fontSize: 22.0)),
              );
          }
        },
      ),
    );
  }

  Future<String> fetchJoke() async {
    var url = "https://api.chucknorris.io/jokes/random?category=dev";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse['value'];
    } else {
      return ("Unexpected error occurred.");
    }
  }
}
