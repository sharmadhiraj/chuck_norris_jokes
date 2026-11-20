import 'package:chuck_norris_jokes/data/favorite_jokes_store.dart';
import 'package:chuck_norris_jokes/models/joke.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class JokeActions extends StatelessWidget {
  const JokeActions({required this.joke, super.key});

  final Joke joke;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Joke>>(
      valueListenable: FavoriteJokesStore.instance,
      builder: (context, _, _) {
        final bool isFavorite = FavoriteJokesStore.instance.isFavorite(joke);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAction(
              label: isFavorite ? "Remove from favorites" : "Add to favorites",
              icon: isFavorite ? Icons.favorite : Icons.favorite_border,
              onPressed: () => FavoriteJokesStore.instance.toggle(joke),
            ),
            _buildAction(
              label: "Copy joke",
              icon: Icons.copy,
              onPressed: () => _copy(context),
            ),
            _buildAction(
              label: "Share joke",
              icon: Icons.share,
              onPressed: () =>
                  SharePlus.instance.share(ShareParams(text: joke.content)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAction({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Semantics(
      button: true,
      label: label,
      child: IconButton(tooltip: label, icon: Icon(icon), onPressed: onPressed),
    );
  }

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: joke.content));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Copied"), duration: Duration(seconds: 1)),
    );
  }
}
