import 'dart:convert';

import 'package:chuck_norris_jokes/models/joke.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteJokesStore extends ValueNotifier<List<Joke>> {
  FavoriteJokesStore() : super(const []);

  static final FavoriteJokesStore instance = FavoriteJokesStore();

  static const String _storageKey = "favorite_jokes";

  Future<void> load() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? saved = preferences.getString(_storageKey);
    if (saved != null) value = Joke.parseList(json.decode(saved));
  }

  bool isFavorite(Joke joke) => value.any((saved) => saved.id == joke.id);

  Future<void> toggle(Joke joke) async {
    value = isFavorite(joke)
        ? value.where((saved) => saved.id != joke.id).toList()
        : [joke, ...value];
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_storageKey, json.encode(value));
  }
}
