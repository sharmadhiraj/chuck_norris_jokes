class Joke {
  const Joke({required this.id, required this.content});

  final String id;
  final String content;

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(id: json["id"] as String, content: json["value"] as String);
  }

  static List<Joke> parseList(dynamic list) {
    if (list is! List) return const [];
    return [for (final dynamic json in list) Joke.fromJson(json)];
  }

  Map<String, dynamic> toJson() => {"id": id, "value": content};
}
