import 'package:chuck_norris_jokes/data/jokes_client.dart';
import 'package:chuck_norris_jokes/models/joke.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test("Joke.parseList reads id and value", () {
    final List<Joke> jokes = Joke.parseList([
      {"id": "a", "value": "one"},
    ]);
    expect(jokes.single.content, "one");
    expect(Joke.parseList(null), isEmpty);
  });

  test("fetchRandomJoke sends category and parses joke", () async {
    final JokesClient client = JokesClient(
      httpClient: MockClient((request) async {
        expect(request.url.queryParameters["category"], "dev");
        return http.Response('{"id":"x","value":"hi"}', 200);
      }),
    );
    expect((await client.fetchRandomJoke(category: "dev")).id, "x");
  });

  test("random joke never uses the explicit category", () async {
    final List<String> requested = [];
    final JokesClient client = JokesClient(
      httpClient: MockClient((request) async {
        if (request.url.path == "/jokes/categories") {
          return http.Response('["dev","explicit"]', 200);
        }
        requested.add(request.url.queryParameters["category"]!);
        return http.Response('{"id":"x","value":"hi"}', 200);
      }),
    );
    for (int i = 0; i < 20; i++) {
      await client.fetchRandomJoke();
    }
    expect(requested.toSet(), {"dev"});
  });

  test("fetchCategories throws on non-200", () async {
    final JokesClient client = JokesClient(
      httpClient: MockClient((_) async => http.Response("", 500)),
    );
    expect(client.fetchCategories(), throwsA(isA<http.ClientException>()));
  });
}
