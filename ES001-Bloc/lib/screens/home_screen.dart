import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_awesome_namer/bloc/random_word/random_word_cubit.dart';

import '../components/big_card.dart';

/// [HomeScreen] is the Widget that shows the home screen.
/// Here we show the [BigCard] Widget and two [ElevatedButton]s.
///
/// [BigCard] shows a pair of words and [ElevatedButton]s allow us to like
/// or unlike the pair of words and generate a new pair of words.
///
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomWordCubit, RandomWordState>(
      builder: (context, state) {
        return Column(
          spacing: 18,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(pairOfWords: state.pairOfWords),
            Row(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => context
                      .read<RandomWordCubit>()
                      .manageFavorite(state.pairOfWords!),
                  icon: Icon(
                    state.listOfFavorites.contains(state.pairOfWords)
                        ? Icons.favorite
                        : Icons.favorite_outline,
                  ),
                  label: Text(
                    state.listOfFavorites.contains(state.pairOfWords)
                        ? 'Unlike'
                        : 'Like',
                  ),
                ),
                ElevatedButton(
                  onPressed: () =>
                      context.read<RandomWordCubit>().generateRandomWord(),
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
