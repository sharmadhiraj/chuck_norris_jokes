class Joke {
  final String avatar;
  final String content;

  Joke(
    this.avatar,
    this.content,
  );

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      json["icon_url"],
      json["value"],
    );
  }
}
