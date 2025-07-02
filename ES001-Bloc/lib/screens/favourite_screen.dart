import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/random_word/random_word_cubit.dart';

/// [FavouriteScreen] is the Widget that shows the favorite words screen.
/// It shows the list of favorite words and allows us to delete them.
/// If there are no favorite words, it shows a message.
/// When deleting a word, we show an alert dialog to confirm the deletion.
///
class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomWordCubit, RandomWordState>(
      builder: (context, state) {
        final listOfFavorites = state.listOfFavorites;
        return listOfFavorites.isEmpty
            ? const Center(child: Text("You have no favorite words"))
            : ListView(
                padding: EdgeInsets.only(top: 12),
                children: [
                  Center(
                    child: Text(
                      "You have ${listOfFavorites.length} favorites: ",
                    ),
                  ),
                  ...listOfFavorites.map(
                    (singleFavorite) => ListTile(
                      leading: IconButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Delete word"),
                            content: Text(
                              "Are you sure you want to delete ${singleFavorite.first} ${singleFavorite.second}?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<RandomWordCubit>()
                                      .manageFavorite(singleFavorite);
                                  Navigator.pop(context);
                                },
                                child: const Text("Delete"),
                              ),
                            ],
                          ),
                        ),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                      title: Text(
                        "${singleFavorite.first} ${singleFavorite.second}",
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
