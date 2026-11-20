import 'package:chuck_norris_jokes/data/jokes_client.dart';
import 'package:chuck_norris_jokes/features/favorites/favorites_screen.dart';
import 'package:chuck_norris_jokes/features/jokes/widgets/category_chips.dart';
import 'package:chuck_norris_jokes/features/jokes/widgets/joke_actions.dart';
import 'package:chuck_norris_jokes/models/joke.dart';
import 'package:chuck_norris_jokes/widgets/state_message.dart';
import 'package:flutter/material.dart';

class JokesScreen extends StatefulWidget {
  const JokesScreen({super.key});

  @override
  State<JokesScreen> createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {
  final JokesClient _client = JokesClient();
  late Future<List<String>> _categories;
  late Future<Joke> _joke;
  String? _category;

  @override
  void initState() {
    super.initState();
    _categories = _client.fetchCategories().catchError((_) => <String>[]);
    _loadJoke();
  }

  void _loadJoke() {
    _joke = _client.fetchRandomJoke(category: _category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildCategories(),
          Expanded(child: _buildJoke()),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Chuck Norris Jokes"),
      actions: [
        Semantics(
          button: true,
          label: "Open favorites",
          child: IconButton(
            tooltip: "Favorites",
            icon: const Icon(Icons.favorite_border),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const FavoritesScreen()),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return FutureBuilder<List<String>>(
      future: _categories,
      builder: (context, snapshot) => CategoryChips(
        categories: snapshot.data ?? const [],
        selected: _category,
        onSelected: (category) => setState(() {
          _category = category;
          _loadJoke();
        }),
      ),
    );
  }

  Widget _buildJoke() {
    return FutureBuilder<Joke>(
      future: _joke,
      builder: (context, snapshot) {
        if (snapshot.hasError) return _buildError();
        final Joke? joke = snapshot.data;
        if (joke == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return _buildLoadedJoke(joke);
      },
    );
  }

  Widget _buildLoadedJoke(Joke joke) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  joke.content,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                JokeActions(joke: joke),
                const SizedBox(height: 16),
                Semantics(
                  button: true,
                  label: "Next joke",
                  child: FilledButton.icon(
                    onPressed: () => setState(_loadJoke),
                    icon: const Icon(Icons.refresh),
                    label: const Text("Next joke"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildError() {
    return StateMessage(
      icon: Icons.cloud_off,
      message: "Could not load a joke.",
      actionLabel: "Try again",
      onAction: () => setState(_loadJoke),
    );
  }
}
