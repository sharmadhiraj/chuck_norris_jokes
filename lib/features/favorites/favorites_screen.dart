import 'package:chuck_norris_jokes/data/favorite_jokes_store.dart';
import 'package:chuck_norris_jokes/models/joke.dart';
import 'package:chuck_norris_jokes/widgets/state_message.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: ValueListenableBuilder<List<Joke>>(
        valueListenable: FavoriteJokesStore.instance,
        builder: (context, jokes, _) => jokes.isEmpty
            ? const StateMessage(
                icon: Icons.favorite_border,
                message:
                    "No favorites yet. Tap the heart on a joke to keep it.",
              )
            : _buildList(jokes),
      ),
    );
  }

  Widget _buildList(List<Joke> jokes) {
    return ListView.separated(
      itemCount: jokes.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) => ListTile(
        title: Text(jokes[index].content),
        trailing: Semantics(
          button: true,
          label: "Remove from favorites",
          child: IconButton(
            tooltip: "Remove",
            icon: const Icon(Icons.favorite),
            onPressed: () => FavoriteJokesStore.instance.toggle(jokes[index]),
          ),
        ),
      ),
    );
  }
}
