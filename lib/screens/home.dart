import 'dart:convert';

import 'package:chuck_norris_jokes/models/joke.dart';
import 'package:chuck_norris_jokes/util/data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(title: Text(appName));
  }

  Widget _buildBody() {
    return FutureBuilder(
      future: _fetchJoke(),
      builder: (BuildContext context, AsyncSnapshot<Joke> snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? snapshot.hasData
                ? _buildJoke(snapshot.data!)
                : _buildError()
            : _buildProgressIndicator();
      },
    );
  }

  Widget _buildJoke(Joke joke) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            "https://api.chucknorris.io/img/chucknorris_logo_coloured_small@2x.png",
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              joke.content,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
          ),
          ElevatedButton(
            onPressed: () => setState(() => {}),
            child: Text("Another Joke"),
          )
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildError() {
    return InkWell(
      onTap: () => setState(() => {}),
      child: Center(
        child: Text("Failed to connect ! Tap to retry !!"),
      ),
    );
  }

  Future<Joke> _fetchJoke() async {
    var url = 'https://api.chucknorris.io/jokes/random?category=dev';
    var response = await http.get(Uri.parse(url));
    return Joke.fromJson(json.decode(response.body));
  }
}
