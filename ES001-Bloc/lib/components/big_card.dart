import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

/// [BigCard] is a Widget that shows a pair of words.
/// It's a customization of the [Card] Widget.
/// It accepts a parameter [pairOfWords] that is the pair of words to show.
///
class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.pairOfWords});

  final WordPair? pairOfWords;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pairOfWords == null
              ? "Qualcosa non va"
              : "${pairOfWords!.first} ${pairOfWords!.second}",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
