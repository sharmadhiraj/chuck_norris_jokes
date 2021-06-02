import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data.dart';
import 'joke.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appName)),
      body: FutureBuilder(
        future: fetchJoke(),
        builder: (BuildContext context, AsyncSnapshot<Joke> snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? snapshot.hasData
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(snapshot.data!.avatar),
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              snapshot.data!.content,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () => setState(() => {}),
                            child: Text('Another Joke'),
                          )
                        ],
                      ),
                    )
                  : InkWell(
                      onTap: () => setState(() => {}),
                      child: Center(
                        child: Text('Failed to connect ! Tap to retry !!'),
                      ),
                    )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<Joke> fetchJoke() async {
    var url = 'https://api.chucknorris.io/jokes/random?category=dev';
    var response = await http.get(Uri.parse(url));
    return Joke.fromJson(json.decode(response.body));
  }
}
