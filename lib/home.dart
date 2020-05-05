import 'dart:convert';

import 'package:flutter_web/material.dart';
import 'package:http/http.dart' as http;

import 'data.dart';
import 'joke.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Joke> _future;

  @override
  void initState() {
    super.initState();
    _future = fetchJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appName)),
      body: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<Joke> snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? snapshot.hasData
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(snapshot.data.avatar),
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              snapshot.data.content,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () => setState(() {
                              _future = fetchJoke();
                            }),
                            child: Text('Another Joke'),
                          )
                        ],
                      ),
                    )
                  : InkWell(
                      child: Center(
                          child: Text('Failed to connect ! Tap to retry !!')),
                      onTap: () => setState(() {
                        _future = fetchJoke();
                      }),
                    )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<Joke> fetchJoke() async {
    var url = 'https://api.chucknorris.io/jokes/random?category=dev';
    var response = await http.get(url);
    return Joke.fromJson(json.decode(response.body));
  }
}
