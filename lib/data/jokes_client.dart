import 'dart:convert';
import 'dart:math';

import 'package:chuck_norris_jokes/data/api_paths.dart';
import 'package:chuck_norris_jokes/models/joke.dart';
import 'package:http/http.dart' as http;

class JokesClient {
  JokesClient({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  static const String _explicitCategory = "explicit";

  final http.Client _httpClient;
  final Random _random = Random();

  Future<Joke> fetchRandomJoke({String? category}) async {
    final String safeCategory = category ?? await _pickRandomCategory();
    final dynamic body = await _get(
      randomJokePath,
      query: {"category": safeCategory},
    );
    return Joke.fromJson(body as Map<String, dynamic>);
  }

  Future<List<String>> fetchCategories() async {
    final dynamic body = await _get(categoriesPath);
    return (body as List)
        .cast<String>()
        .where((category) => category != _explicitCategory)
        .toList();
  }

  Future<String> _pickRandomCategory() async {
    final List<String> categories = await fetchCategories();
    return categories[_random.nextInt(categories.length)];
  }

  Future<dynamic> _get(String path, {Map<String, String>? query}) async {
    final http.Response response = await _httpClient.get(
      Uri.https(apiHost, path, query),
    );
    if (response.statusCode != 200) {
      throw http.ClientException(
        "HTTP ${response.statusCode}",
        response.request?.url,
      );
    }
    return json.decode(response.body);
  }
}
